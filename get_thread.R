# author: @bryn-g
# date: 2023-05-28

# options
options(scipen = 999)
options(encoding = "UTF-8")

source("./utils.R")

# setup
logging <- TRUE
if (logging) utils$setup_logging()

# init praw
reddit <- prw$Reddit(client_id = Sys.getenv("REDDIT_CLIENT_ID"),
                     client_secret = Sys.getenv("REDDIT_CLIENT_SECRET"),
                     user_agent = Sys.getenv("REDDIT_CLIENT_UA"),
                     check_for_async = FALSE)

## 1. collect thread data

# thread url
url <- "https://www.reddit.com/r/xxxxxx/comments/xxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx/"

# get submission
submission <- reddit$submission(url = url)

# get replies
submission$comment_sort <- "best"
invisible(submission$comments$replace_more(limit = NULL))
comments <- submission$comments$list()

# process users
df_op_user <- pd$json_normalize(builtins$vars(submission$author))

df_users <- map_dfr(
  comments,
  function(x) {
    y <- tryCatch({
      as_tibble(pd$json_normalize(builtins$vars((x$author))))
    }, error = function(e) {
      cols <- c("`_listing_use_sort`", "name", "`_reddit`", "`_fetched`")
      vals <- c(NA, NA_character_, list(NA), NA)
      names(vals) <- cols
      as_tibble(vals)
    })
  }
)

# process replies
df_replies <- map_dfr(
    comments,
    function(x) x |> builtins$vars() |> flat_pd_df(pd)
  )

df_replies <- df_replies |> str_comment_df(df_users)

# combine op and replies
df_op <- submission |> builtins$vars() |> flat_pd_df(pd) |> str_comment_df(df_op_user)
df <- bind_rows(df_op, df_replies)

## 2. create thread networks

library(ggraph)
library(tidygraph)

# activity network
edges <- df_replies |> select(from = comment_id, to = parent_id, "subreddit_id")
nodes <- df |> relocate(comment_id)

g <- tbl_graph(nodes = nodes, edges = edges, directed = TRUE)

# plot
# ggraph(g, layout = "kk") + geom_edge_link() + geom_node_point() + geom_node_text(aes(label = comment_id))

# actor network
comment_authors <- df |> select("comment_id", "author_id", "author_name")

edges <- df |> left_join(comment_authors |> rename_with(~ paste0("parent.", .x)), by = c("parent_id" = "parent.comment_id"))
edges <- edges |> select(from = "author_id", to = "parent.author_id") |> filter(!is.na(to))

nodes <- comment_authors |> select(-"comment_id") |> distinct(author_id, .keep_all = TRUE)

g2 <- tbl_graph(nodes = nodes, edges = edges, directed = TRUE)

# plot
# ggraph(g2, layout = "kk") + geom_edge_link() + geom_node_point() + geom_node_text(aes(label = author_name))

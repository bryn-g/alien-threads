# author: @bryn-g
# date: 2023-05-28

library(dplyr)
library(purrr)
library(tibble)
library(tidyr)
library(reticulate)

# import python modules
builtins <- import_builtins()
pd <- import("pandas")
prw <- import("praw")
utils <- import_from_path("utils")

# use python env
use_virtualenv('./.venv', required = TRUE)

# read env variables
readRenviron(".env")

# flatten df list columns
flat_pd_df <- function(x, pd) {
  x |>
    pd$json_normalize() |>
    as_tibble() |>
    mutate_if(is.list, ~ paste0(., collapse = ","), na.rm = TRUE)
}

# structure and add users to comment df
str_comment_df <- function(df, df_users) {
  if (!"parent_id" %in% names(df)) df <- df |> mutate(parent_id = NA_character_, body = selftext, type = "op")
  if (!"title" %in% names(df)) df <- df |> mutate(title = NA_character_, type = "comment")
  df |>
    select(
      "subreddit_id",
      "parent_id",
      comment_id = name,
      "created_utc",
      author_id = author_fullname,
      "title",
      "body",
      "type"
    ) |>
    bind_cols(df_users |> select(author_name = name)) |>
    relocate("author_name", .after = "author_id")
}

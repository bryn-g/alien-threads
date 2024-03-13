# alien-threads
:alien: R project for the collection and creation of Reddit conversation thread networks. Uses the [PRAW](https://praw.readthedocs.io/en/stable/#package-info) Python module to access and collect data from the Reddit API via the R [reticulate](https://rstudio.github.io/reticulate/) package.

> [!NOTE]
> This project is in an initial exploratory phase and does not yet have an interface or package. Future versions will see it formalised into an R package with expanded capabilities.

Perform the following steps after installing Python and R reticulate. 

### Initial python3 setup

1. A python environment named `.venv` is required in the R project directory. Create the environment and install the required modules.
```sh
# create environment
$ python -m pip install --upgrade pip
$ python -m venv ./.venv/

# activate environment
$ source ./.venv/Scripts/activate

# install required python modules
(.venv) $ pip install -r requirements.txt --upgrade

# finish
(.venv) $ deactivate
```

2. Add Reddit API keys to `.env` file in the R project directory.
```
REDDIT_CLIENT_ID=xxxxxxxxxxx
REDDIT_CLIENT_SECRET=xxxxxxxxxxxxx
REDDIT_CLIENT_UA="my alien reddit script"
NON_INTERACTIVE_FILE=false
```

### Collecting Reddit threads

1. Edit and use the `get_thread.R` script. Uses raw URL's for Reddit threads specified by the following variable `url <- "https://www.reddit.com/r/xxxxxx/comments/xxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx/"`.

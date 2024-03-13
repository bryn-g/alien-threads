# alien-threads
:alien: Project for the collection of reddit conversation threads using the PRAW python package from R.

### initial python3 setup

- requires a python environment named `.venv` in R project directory
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
- add reddit api keys to `.env` file in R project directory
```
REDDIT_CLIENT_ID=xxxxxxxxxxx
REDDIT_CLIENT_SECRET=xxxxxxxxxxxxx
REDDIT_CLIENT_UA="my alien reddit script"
NON_INTERACTIVE_FILE=false

```

### collect and process threads

- edit and run the `get_thread.R` script

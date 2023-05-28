# alien-wear
:alien: Reddit data pipeline.

### intial python3 setup

- requires a python environment named `.venv`
```sh
# create environment
$ python -m pip install --upgrade pip
$ python -m venv ./.venv/

# activate environment
$ ./.venv/Scripts/activate

# install required python modules
(.venv) $ pip install -r requirements.txt --upgrade

# finish
(.venv) $ deactivate
```
- add reddit api keys to `.env` file
```
REDDIT_CLIENT_ID=xxxxxxxxxxx
REDDIT_CLIENT_SECRET=xxxxxxxxxxxxx
REDDIT_CLIENT_UA="my alien reddit script"
NON_INTERACTIVE_FILE=false

```

### collect and process threads

- edit and run the `get_thread.R` script

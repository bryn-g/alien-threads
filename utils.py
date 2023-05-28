# -*- coding: utf-8 -*-
"""
helper functions

@author: bryn-g
"""

import os
from datetime import datetime as dt
from dotenv import load_dotenv
import logging

def get_api_keys():
    """ get api key values from .env file """
    load_dotenv()
    reddit_api_auth = {
        "client_id": os.environ.get("REDDIT_CLIENT_ID"),
        "client_secret": os.environ.get("REDDIT_CLIENT_SECRET"),
        "client_ua": os.environ.get("REDDIT_CLIENT_UA")
    }
    return reddit_api_auth


def get_dt_str():
    """ get formatted datetime string from current timestamp """
    return f"{dt.now().strftime('%Y-%m-%d_%H%M%S')}"


def chunks(values, n):
    """ return chunks of n size from values """
    for i in range(0, len(values), n):
        yield values[i:i + n]
        

def setup_logging():
  """ setup praw logging """
  handler = logging.StreamHandler()
  handler.setLevel(logging.DEBUG)
  for logger_name in ("praw", "prawcore"):
      logger = logging.getLogger(logger_name)
      logger.setLevel(logging.DEBUG)
      logger.addHandler(handler)

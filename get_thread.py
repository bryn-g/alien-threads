# -*- coding: utf-8 -*-
"""
uses praw to retrieve reddit thread

@author: bryn-g
"""

import json
from pathlib import Path
import sys
import praw as praw
from praw.models import MoreComments
import pandas as pd
from pandas import DataFrame
from utils import get_api_keys

def main():
    # api keys
    reddit_auth = get_api_keys()
    
    reddit = praw.Reddit(
        client_id=reddit_auth["client_id"],
        client_secret=reddit_auth["client_secret"],
        user_agent=reddit_auth["client_ua"]
    )
    
    url = "https://www.reddit.com/r/xxxxxx/comments/xxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx/"
    submission = reddit.submission(url=url)
    
    submission.comments.replace_more(limit=None)
    
    # comments = submission.comments
    df_rows = [[comment.parent_id, comment.id, comment.score, comment.created, comment.body] for comment in submission.comments.list()]
    df = pd.DataFrame(df_rows, columns=['Parent ID', 'Comment ID', 'Score', 'Created', 'Body'])

    df.to_csv('thread.csv')

    for comment in submission.comments.list(): 
        n_replies = len(comment.replies)
        first_reply_id = comment.replies[0].id
        
        # attribute names
        for c in comment.__dict__:
            print(c)

if __name__ == "__main__":
    main()

#!/usr/bin/python

"""
Command line script
Works in 2 ways:
1) Show number of occurrences of the provided word
    Example:
    $ python finalresults.py hello
    $ Total number of occurrences of "hello": 10

2) Prints all words in ascending order and their number of occurrences.
    Example:
    $ python finalresults.py
    $ ('About', 2)
    $ ('Best', 4)
    $ ('Chelsea', 1)
    ...
"""

import sys
import psycopg2

import os
parentdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
access_path = os.path.join(parentdir, 'src')
os.sys.path.insert(0, access_path)
from access import db_access

from operator import itemgetter

get_all_words = False

try:
    find_word = sys.argv[1]
except IndexError:
    get_all_words = True

conn = psycopg2.connect(**db_access)

cur = conn.cursor()

# Check if table is empty
cur.execute("SELECT True FROM tweetwordcount LIMIT 1;")  # returns None if table is empty and True if there are rows

if not cur.fetchone():
    print('Table is empty')

else:
    if get_all_words:
        cur.execute("SELECT * FROM tweetwordcount;")
    else:
        cur.execute("SELECT * FROM tweetwordcount WHERE word=%s;", (find_word,))

    word_n_amount = cur.fetchall()

    if get_all_words:
        word_n_amount.sort(key=itemgetter(0))
        for item in word_n_amount:
            print(item)

    else:
        if not word_n_amount:
            amount = 0
        else:
            amount = word_n_amount[0][1]

        print('Total number of occurrences of "%s": %s' % (find_word, amount))

cur.close()
conn.close()

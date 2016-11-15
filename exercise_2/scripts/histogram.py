#!/usr/bin/python

"""
Command line script
Prints words in descending order of occurrences within provided range
    Example:
    $ python histogram.py 3,8 or python histogram.py 3, 8 or python histogram.py 3 8
    $ Total number of occurences of "hello": 10
"""

import sys
import psycopg2

import os
parentdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
access_path = os.path.join(parentdir, 'src')
os.sys.path.insert(0, access_path)
from access import db_access

from operator import itemgetter

try:
    try:
        min_value = sys.argv[1].replace(',', '')
        max_value = sys.argv[2].replace(' ', '').split(',')[0]
    except IndexError:
        min_value, max_value = sys.argv[1].split(',')

    conn = psycopg2.connect(**db_access)

    cur = conn.cursor()

    # Check if table is empty
    cur.execute("SELECT True FROM tweetwordcount LIMIT 1;")  # returns None if table is empty and True if there are rows
    if not cur.fetchone():
        print('Table is empty')

    else:
        cur.execute("SELECT * FROM tweetwordcount WHERE word_count >= %s and word_count <= %s;", (min_value, max_value))

        word_n_amount = cur.fetchall()

        word_n_amount.sort(key=itemgetter(1), reverse=True)
        for item in word_n_amount:
            print('\t%s: %s' % (item[0], item[1]))

    cur.close()
    conn.close()

except IndexError:
    print('Please provide min and max values, i.e.: python histogram.py 3,8')

except ValueError:
    print('Please provide just 2 values, i.e.: python histogram.py 3,8')

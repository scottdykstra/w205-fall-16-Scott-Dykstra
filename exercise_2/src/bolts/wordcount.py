import psycopg2

from access import db_access
from streamparse.bolt import Bolt


class WordCounter(Bolt):
    def process(self, tup):
        word = tup.values[0]

        # Connecting to a database
        conn = psycopg2.connect(**db_access)

        # Check if table exists
        # cur = conn.cursor()
        # cur.execute("SELECT exists(SELECT * FROM information_schema.tables WHERE table_name=%s)", (table_name,))
        # # Creates a new table
        # if cur.fetchone()[0] is not True:
        #     cur.execute("CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY NOT NULL, word_count INT NOT NULL);")
        #
        # conn.commit()
        # conn.close()

        # INSERT or UPDATE. 1 in (word, 1) means default count value of the word
        with conn:
            with conn.cursor() as cur:
                cur.execute('INSERT INTO tweetwordcount (word, word_count) VALUES (%s, %s) '
                            'ON CONFLICT (word) DO UPDATE SET word_count = tweetwordcount.word_count + 1;', (word, 1))

        conn.close()

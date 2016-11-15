Installation and Run:
1) $ sudo apt-get install python3.5-venv
2) $ pyvenv-3.5 ~/project/
3) sudo apt-get install gcc
4) sudo apt-get install python3.5-dev

3) Install Java if needed 

4) Install PostgreSQL >= 9.5 (if needed)
    $ sudo apt-get install libpq-dev
    $ sudo apt-get install postgresql postgresql-contrib

5) Install Apache Storm >= 1.0.0 (if needed)
    $ wget http://apache.ip-connect.vn.ua/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz -P ~/project/
    $ tar -xvzf ~/project/apache-storm-1.0.2.tar.gz -C ~/project/
    $ ~/project/apache-storm-1.0.2/bin

    $ sudo nano /etc/environment
    to the end of PATH add the next line (change USER_NAME to the one, where you store Storm)
    :/home/USER_NAME/project/apache-storm-1.0.2/bin

6) Install Lein
    $ wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P ~/project/bin/
    $ chmod a+x ~/project/bin/lein
    $ ~/project/bin/lein

7) $ cd ~/project/
8) $ git clone https://TitanFighter@bitbucket.org/TitanFighter/ex2tweetwordcount.git
9) $ cd ex2tweetwordcount/
10) $ source /home/ubuntu/project/bin/activate
11) $ export LC_ALL="en_US.UTF-8"
12) $ pip install -r requirements.txt

13) Create DB 'tcount' and a new user 'tcountuser':
    $ sudo -u postgres psql
	    -> CREATE DATABASE tcount;
	    -> CREATE USER tcountuser WITH password 'TcountPass';
	    -> GRANT ALL PRIVILEGES ON DATABASE tcount TO tcountuser;
	    -> \q

14) Create Table 'tweetwordcount' on behave of just created user 'tcountuser':
    $ psql -h localhost tcount tcountuser
	    -> CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY NOT NULL, word_count INT NOT NULL);
	    -> \q

15) Get Twitter application credentials.
    In order to do that it is necessary to:
    1. Login to Twitter ( https://www.twitter.com/ ).
    2. Visit https://apps.twitter.com and click on "Create New App".
    3. Fill in the application name, description, and Website.  Ignore Callback URL field.
    4. Agree to the terms and agreements and click on "Create your Twitter Application"

    Once you have successfully created an application, it should take you to the newly created
    application. Here you must create access keys for subsequent operations by your application.
    To do so, use the following procedure:
    1. Click on the "Keys and Access Tokens" tab.
    2. Click on "Create my Access Token" near the bottom of the page.

    Now you have four things (as blurred above):
    1. A consumer key that identifies your application.
    2. A consumer secret that acts as a "password" for your application.
    3. An access token that identifies your authorized access.
    4. An access token secret that acts as a "password" for that authorized access.
    At any point, you can revoke the access key or regenerated any of these values. To completely
    disable the application, you must delete the application. This does remove the consumer key,
    secret, and access tokens from Twitter's system and any program using them will immediately
    stop working.

16) Enter your DB and Twitter credentials in .../ex2tweetwordcount/access.py
    According to the steps #13 and #14 above, ‘db_access’ dictionary must look like:
    db_access = {
        'database' : 'tcount',
        'user'         : 'tcountuser',
        'password': 'TcountPass',
        'host'         : 'localhost',
        'port'          : '5432'
    }

    Values of keys of ‘twitter_access’ dictionary must be filled in according to the credentials received in step #15 above.

17) Run application (i.e. start Twitter streaming)
    $ sparse run

If you have error: RuntimeError: Unable to run 'storm version'!
Run:
export PATH=$PATH:/home/ubuntu/project/apache-storm-1.0.2/bin

18) Run finalresults utils:
    $ cd ~/project/ex2tweetwordcount/scripts/
    $ python3 finalresults.py
    or
    $ python3 finalresults.py some_word

    Example:
    $ python3 finalresults.py hello

19) Run histogram script:
    $ cd ~/project/ex2tweetwordcount/scripts/
    $ python3 histogram.py min_range, max_range

    Example:
    $ python3 histogram.py 3, 8
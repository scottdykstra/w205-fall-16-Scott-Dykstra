import time
import tweepy
import queue

from access import twitter_access
from streamparse.spout import Spout


def auth_get(auth_key):
    if auth_key in twitter_access:
        return twitter_access[auth_key]
    return None


################################################################################
# Class to listen and act on the incoming tweets
################################################################################
class TweetStreamListener(tweepy.StreamListener):

    def __init__(self, listener):
        self.listener = listener
        super(self.__class__, self).__init__(listener.tweepy_api())

    def on_status(self, status):
        self.listener.queue().put(status.text, timeout=0.01)
        return True
  
    def on_error(self, status_code):
        return True  # keep stream alive
  
    def on_limit(self, track):
        return True  # keep stream alive


class Tweets(Spout):
    outputs = ['tweet']
    langs = ["en"]
    track = ["a", "the", "i", "you", "u"]

    def initialize(self, stormconf, context):
        self._queue = queue.Queue(maxsize=100)

        consumer_key = auth_get("consumer_key") 
        consumer_secret = auth_get("consumer_secret") 
        auth = tweepy.OAuthHandler(consumer_key, consumer_secret)

        if auth_get("access_token") and auth_get("access_token_secret"):
            access_token = auth_get("access_token")
            access_token_secret = auth_get("access_token_secret")
            auth.set_access_token(access_token, access_token_secret)

        self._tweepy_api = tweepy.API(auth)

        # Create the listener for twitter stream
        listener = TweetStreamListener(self)

        # Create the stream and listen for english tweets
        stream = tweepy.Stream(auth, listener, timeout=None)
        stream.filter(languages=self.langs, track=self.track, async=True)

    def queue(self):
        return self._queue

    def tweepy_api(self):
        return self._tweepy_api

    def next_tuple(self):
        try:
            tweet = self.queue().get(timeout=0.1)
            if tweet:
                self.queue().task_done()
                self.emit([tweet])
 
        except queue.Empty:
            self.log("Empty queue exception 1")
            time.sleep(0.1)

    def ack(self, tup_id):
        pass  # if a tuple is processed properly, do nothing

    def fail(self, tup_id):
        pass  # if a tuple fails to process, do nothing


class Tweets2(Tweets):
    langs = ['en']
    track = ["hello", "beer", "birthday"]


class Tweets3(Tweets):
    langs = ['en']
    track = ["drink", "smoke", "tv"]

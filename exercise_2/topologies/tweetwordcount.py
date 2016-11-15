"""
Word count topology
"""

from streamparse import Topology

from spouts.tweets import Tweets, Tweets2, Tweets3
from bolts.parse import ParseTweet
from bolts.wordcount import WordCounter


class TweetSpout(Topology):
    tweet_spout_1 = Tweets.spec()
    tweet_spout_2 = Tweets2.spec()
    tweet_spout_3 = Tweets3.spec()

    parse_tweet_bolt_1 = ParseTweet.spec(inputs=[tweet_spout_1, tweet_spout_2], par=4)
    parse_tweet_bolt_2 = ParseTweet.spec(inputs=[tweet_spout_1, tweet_spout_2, tweet_spout_3], par=6)
    parse_tweet_bolt_3 = ParseTweet.spec(inputs=[tweet_spout_3], par=2)

    word_count_bolt_1 = WordCounter.spec(inputs=[parse_tweet_bolt_1, parse_tweet_bolt_2, parse_tweet_bolt_3], par=6)
    word_count_bolt_2 = WordCounter.spec(inputs=[parse_tweet_bolt_1, parse_tweet_bolt_3], par=4)


twitter = require("../lib/twitter_client")
Models = require("../models")
Tweet = Models.Tweet
Settings = Models.Settings
module.exports = start: (onNewTweet) ->
  twitter
    #.stream "statuses/sample", {}, (stream) ->
    .stream 'statuses/filter', {track:"nolatech,wileycousins"}, (stream) ->
      stream.on "data", (twitter_obj) ->
        if twitter_obj.entities and twitter_obj.entities.hashtags.length > 0
          tweet = Tweet.build(twitter_obj)
          #console.log tweet
          #tweet.save (err) ->
            #return console.log(err)  if err
          onNewTweet tweet

      stream.on "error", (err) ->
        console.log err


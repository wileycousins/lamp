Models = require("../models")
Tweet = Models.Tweet
Settings = Models.Settings

module.exports =
  start: (twitter, onNewTweet) ->
    console.log "starting stream"
    twitter
      #.stream "statuses/sample", {}, (stream) ->
      .stream 'statuses/filter', {track:"nola,hcolewiley,nolatech,wileycousins"}, (stream) ->
        stream.on "data", (twitter_obj) ->
          if twitter_obj.entities and twitter_obj.entities.hashtags.length > 0
            tweet = Tweet.build(twitter_obj)
            console.log "built it!"
            onNewTweet tweet
            #tweet.save (err, tweet) ->
              #if err
                #return console.log err
              #onNewTweet tweet

        stream.on "error", (err) ->
          console.log "ERROR ON STREAMER: #{err}"


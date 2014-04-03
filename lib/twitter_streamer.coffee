Models = require("../models")
Tweet = Models.Tweet
Settings = Models.Settings

module.exports =
  start: (twitter, user, next) ->
    console.log "starting stream"
    twitter
      #.stream "statuses/sample", (streamer) ->
      .stream 'statuses/filter', {track:user.twitter_track}, (streamer) ->
        streamer.on "data", (data) ->
          if data.entities and data.entities.hashtags.length > 0
            data['twitter_user'] = data.user
            data.user = user
            tweet = Tweet.build data
            tweet.user = user.id
            tweet.save (err, tweet) ->
              if err
                return console.log err
              console.log "saved tweet"
              user.newTweet tweet

        streamer.on "error", (err) ->
          console.log "ERROR ON STREAMER: #{err}"

        next streamer


mongoose = require("mongoose")
models = require("./models")
Tweet = models.Tweet
User = models.User

module.exports = (io) ->

  io.configure "production", ->
    io.set "transports", ["xhr-polling"]
    io.set "polling duration", 10
    io.set "log level", 1

  io.configure "development", ->
  
  io.sockets.on "connection", (socket) ->
    socket.emit "connection", "yummyPizza"

    socket.on "disconnect", (msg) ->
      user = socket['user']
      console.log "disconnet: #{user?.id}"
      #User.findById user?.id, (err, user) ->
        #return console.log err if err
        #return "" if !user
        #console.log "stop tweets for #{user.name}"
        #user.stopTweetStream()
      #stream = socket['stream']
      #if stream?
        #console.log 'killing mongoose stream'
        #stream.destroy()

    socket.on "addTag", (user, tag) ->
      if user?
        User.findByIdAndUpdate user.id, $addToSet: twitter_tags: tag, (err, user) ->
          console.log err if err
          console.log "user.twitter_track: #{user.twitter_track}"
          user.streamTweets()
          socket.emit "user", user

    socket.on "removeTag", (user, tag) ->
      if user?
        User.findByIdAndUpdate user.id, $pull: twitter_tags: tag, (err, user) ->
          console.log "ERROR on remove tag: #{err}" if err
          console.log "user.twitter_track: #{user.twitter_track}"
          user.streamTweets()
          socket.emit "user", user


    socket.on "tweets", (user) ->
      if user?
        socket['user'] = user
        socket['stream'] = stream = Tweet.find( user:user.id ).tailable().limit(10).stream()

        stream.on "error", (err) ->
          console.error err

        stream.on "data", (doc) ->
          socket.emit "tweet", doc

        stream.on "close", (err) ->
          console.log 'closed mongoose stream'

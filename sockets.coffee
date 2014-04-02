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
  
  # whatever!!!
  io.sockets.on "connection", (socket) ->
    socket.emit "connection", "yummyPizza"

    socket.on "tweets", (user) ->
      console.log "tweets for:"
      console.log user
      stream = Tweet.find( user:user.id ).tailable().limit(10).stream()
      stream.on "error", (err) ->
        console.error err
        return

      stream.on "data", (doc) ->
        io.sockets.emit "tweet", doc
        return

  return

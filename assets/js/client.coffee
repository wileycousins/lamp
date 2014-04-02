#=require socket.io
#=require jquery
#=require bootstrap

$(window).ready ->
  a = window.a || {}

  socket = io.connect() 

  socket.on "connection", (msg) ->
    console.log "connected: #{msg}"
    socket.emit "tweets", a.me

  socket.on "tweet", (msg) ->
    tweet = $(jade.templates["tweet.jade"] msg )
    $("#tweets").append(tweet)


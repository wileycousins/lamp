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
    $("#tweets").prepend(tweet)

  socket.on "user", (user) ->
    tags = ""
    $("#tweet-tags").html ''
    for tag in user.twitter_tags
      taghtml = $(jade.templates["tweet_tag.jade"] tag:tag )
      $("#tweet-tags").append taghtml



  $("#add-twitter-tag").click ->
    tag = $("#new-twitter-tag").val()
    $("#new-twitter-tag").val ''
    socket.emit "addTag", a.me, tag


#=require socket.io
#=require jquery
#=require bootstrap

a = window.a || {}

bindRemoveTag = ->
  $(".remove-twitter-tag").unbind 'click'
  $(".remove-twitter-tag").click ->
    tag = $($(@).parent('p'))
    a.socket.emit "removeTag", a.me, tag.text().replace("\n","")
    $(tag).remove()

$(window).ready ->
  a = window.a || {}

  a.socket = socket = io.connect() 

  socket.on "connection", (msg) ->
    console.log "connected: #{msg}"
    if a.me?
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
    bindRemoveTag()

  $("#new-twitter-tag").keypress (e)->
    if e.which == 13 || e.keyCode == 13
      $("#add-twitter-tag").trigger 'click'

  $("#add-twitter-tag").click ->
    tag = $("#new-twitter-tag").val()
    $("#new-twitter-tag").val ''
    socket.emit "addTag", a.me, tag

  bindRemoveTag()


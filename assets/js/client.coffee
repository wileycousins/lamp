#=require socket.io
#=require jquery
#=require bootstrap

a = window.a || {}

$(window).ready ->
  a = window.a || {}

  a.socket = socket = io.connect() 

  socket.on "connection", (msg) ->
    console.log "connected: #{msg}"


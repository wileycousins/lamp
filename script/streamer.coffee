twitter = require("../lib/twitter_client")
streamer = require("../lib/twitter_streamer")
mongoose = require("mongoose")
https = require("https")

#seacher
console.log "starting streamer..."
streamer.start (tweet) ->
  console.log tweet
  req = https.get "https://agent.electricimp.com/3RWsFhdTP9P-?color=B7C22C", (res) ->

    #console.log('STATUS: ' + res.statusCode);
    #console.log('HEADERS: ' + JSON.stringify(res.headers));

    # Buffer the body entirely for processing as a whole.
    bodyChunks = []

    # You can process streamed parts here...
    res.on("data", (chunk) ->
      bodyChunks.push chunk
    ).on "end", ->
      body = Buffer.concat(bodyChunks)

  #console.log('BODY: ' + body);
  req.on "error", (e) ->
    console.log "ERROR: " + e.message


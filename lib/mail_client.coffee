

inbox = require("inbox")
inspect = require("util").inspect
config = require '../config'

module.exports = (user, next) ->
  console.log 'got in the mail client'

  auth = 
    user: user.email
    clientId: config.google.clientID
    clientSecret: config.google.clientSecret
    #refreshToken: user.auth_keys.google.refreshToken
    accessToken: user.auth_keys.google.key
    timeout: 3600
  console.log "email auth: "
  console.log auth
  client = inbox.createConnection false, "imap.gmail.com",
    secureConnection: true
    auth:
      XOAuth2: auth
    debug: true
  
  client.on "connect", ->
    console.log "imap ready"
    next null, client 
  
  client.on "error", (err) ->
    console.log err
    next err, null
  
  client.connect()
  

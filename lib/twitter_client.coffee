Twitter = require("twitter")
config = require("../config")

module.exports = (user, next) ->
  twitter = new Twitter(
    consumer_key: config.twitter.consumerKey
    consumer_secret: config.twitter.consumerSecret
    access_token_key: user.auth_keys.twitter.key
    access_token_secret: user.auth_keys.twitter.secret
  )

  twitter.verifyCredentials (data) ->
    console.log "Twitter Auth Verified!"
    console.log data
    if !data || data?.error
      return next data, false
    next false, twitter

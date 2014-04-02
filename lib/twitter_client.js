var Twitter = require('twitter');
var config = require("../config");

var twitter = new Twitter({
    consumer_key        : config.twitter.CONSUMER_KEY
  , consumer_secret     : config.twitter.CONSUMER_SECRET
  , access_token_key    : config.twitter.ACCESS_KEY
  , access_token_secret : config.twitter.ACCESS_SECRET
});

twitter.verifyCredentials(function (data) {
  console.log("Twitter Auth Verified!");
});

module.exports = twitter;

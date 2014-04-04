passport = require("passport")
User = require("../models").User

exports.twitter = passport.authenticate "twitter", scope: [ 'email' ]

exports.twitterCallback = passport.authenticate "twitter",
  successRedirect: "/auth/success"
  failureRedirect: "/auth/failure"
  failureFlash: true

exports.google = passport.authenticate "google", scope: [
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email',
  ]

exports.googleCallback = passport.authenticate "google",
    successRedirect: "/auth/success"
    failureRedirect: "/auth/failure"
    failureFlash: true

exports.facebook = passport.authenticate "facebook", scope: [ 'email' ]

exports.facebookCallback = passport.authenticate "facebook",
  successRedirect: "/auth/success"
  failureRedirect: "/auth/failure"
  failureFlash: true

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"

exports.success = (req, res) ->
  req.session = req.session || {}
  res.redirect "/profile"

exports.failure = (req, res) ->
  res.render "error.jade", error: "Login failure"

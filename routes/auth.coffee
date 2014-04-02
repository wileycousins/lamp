passport = require("passport")
User = require("../models").User

exports.twitter = passport.authenticate "twitter", scope: [ 'email' ]

exports.twitterCallback = passport.authenticate "twitter",
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
  res.redirect "/about"

exports.success = (req, res) ->
  req.session = req.session || {}
  res.redirect "/profile"

exports.failure = (req, res) ->
  res.render "error.jade", error: "Login failure"

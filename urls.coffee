config = require './config'
routes = require './routes'
User = require('./models').User
_ = require 'underscore'


module.exports = (app) ->
  app.get "/robots.txt", (req, res) ->
    res.type('text/plain')
    res.send "User-agent: *\n"+
        "Disallow: /images/\n"+
        "Disallow: /css/\n"+
        "Disallow: /js/\n"

  app.all "/login", (req, res) ->
    return res.redirect('/auth/twitter')

  app.all "/logout", (req, res) ->
    return res.redirect('/auth/logout')

  app.all "*", (req, res, next) ->
    req.session = req.session || {}
    res.args =
      me: req.user
      stripe_js: config.stripe_js
    if res.args.me
      User.findById(res.args.me._id).populate('addresses').exec (err, user) ->
        res.args.me = user
        next()
    else
      next()

  app.get "/", (req, res) ->
    res.render "index.jade", res.args

  app.get "/email", (req, res) ->
    if req.user
      res.render "email.jade", res.args
    else
      res.redirect '/'

  app.get "/twitter", (req, res) ->
    if req.user
      req.user.streamTweets()
      res.render "profile.jade", res.args
    else
      res.redirect '/'

  app.get "/api/users", routes.users.api.list
  app.get "/api/users/:id", routes.users.api.show
  app.post "/api/users", routes.users.api.create
  app.put "/api/users/:id", routes.users.api.update
  app.delete "/api/users/:id", routes.users.api.remove

  app.get "/profile", routes.users.show

  if config.twitter
    app.get "/auth/twitter", routes.auth.twitter
    app.get "/auth/twitter/callback", routes.auth.twitterCallback

  if config.facebook
    app.get "/auth/facebook", routes.auth.facebook
    app.get "/auth/facebook/callback", routes.auth.facebookCallback

  app.get "/auth/success", routes.auth.success
  app.get "/auth/failure", routes.auth.failure
  app.get "/auth/logout", routes.auth.logout

  app.all "/api/*", (req, res) ->
    res.json res.jsonData


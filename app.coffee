
# export jade templates to reuse on client side
# This includes a kind of terrible cache-buster hack
# It generates a new cache-busting query string for the script tag every time the server starts
# This should probably only happen every time there's a change to the templates.js file

# development only

# all environments

# use the connect assets middleware for Snockets sugar
config = require './config'
stylus = require 'stylus'
ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"
  return
express = require("express")
#routes = require("./routes")
http = require("http")
path = require("path")
passport = require("passport")
TwitterStrategy = require("passport-twitter").Strategy
io = require("socket.io")
mongoose = require("mongoose")
socketIo = require("socket.io")
connectAssets = require("connect-assets")
#sockets = require("./sockets")
models = require("./models")
User = models.User
jadeBrowser = require("jade-browser")
passport.serializeUser (user, done) ->
  done null, user.uid
  return

passport.deserializeUser (uid, done) ->
  User.findOne
    uid: uid
  , (err, user) ->
    done err, user
    return

  return

passport.use new TwitterStrategy
  consumerKey: config.twitter.CONSUMER_KEY
  consumerSecret: config.twitter.CONSUMER_SECRET
  callbackURL: "http://" + config.url + "/auth/twitter/callback"
, (token, tokenSecret, profile, done) ->
  User.findOne
    uid: profile.id
  , (err, user) ->
    if user
      done null, user
    else
      user = new User()
      user.provider = "twitter"
      user.uid = profile.id
      user.name = profile.displayName
      user.image = profile._json.profile_image_url
      user.save (err) ->
        throw err  if err
        done null, user

# connect the database
mongoose.connect config.mongodb

# create app, server, and web sockets
app = express()
#if process.env.NODE_ENV != 'production'
  #server = https.createServer(credentials, app)
#else
server = http.createServer(app)

compile = (str, path) ->
  stylus(str).set('filename', path).use(nib())

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  
  # use the connect assets middleware for Snockets sugar
  app.use require("connect-assets")()
  app.use express.favicon()
  app.use express.logger(config.loggerFormat)
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(config.sessionSecret)
  app.use express.session(secret: "shhhh")
  #app.use passport.initialize()
  #app.use passport.session()
  app.use app.router
  app.use stylus.middleware
        src: path.join(__dirname,'assets')
        compile: compile
  app.use express.static path.join __dirname, "assets"  
  app.use express.static path.join __dirname, "public"  
  app.use express.errorHandler()  if config.useErrorHandler

#require("./urls")(app)

server.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")



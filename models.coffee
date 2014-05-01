_ = require "underscore"
mongoose = require("mongoose")
https = require("https")
config = require './config'

Schema = mongoose.Schema
Mixed = Schema.Types.Mixed

ProviderSchema = new Schema
  name: String

UserSchema = new Schema
  providers: [
    type: Schema.ObjectId
    ref: 'Provider'
  ]
  profiles: Mixed
  auth_keys: Mixed
  twitter_tags: [String]
  imp_url:
    type: String
    default: "https://agent.electricimp.com/3RWsFhdTP9P-?"
  name: String
  email: String
  image: String
  created:
    type: Date
    default: Date.now
,
  toObject: virtuals: true
  toJSON: virtuals: true

UserSchema.virtual('twitter_track').get ->
  track = ""
  i = -1
  while ++i < @.twitter_tags.length 
    track += @.twitter_tags[i]
    if i < @.twitter_tags.length - 1
      track += ","
  return track

UserSchema.static 'authGoogle', (req, token, secret, profile, next) ->
  console.log req.body
  User.findOne("profiles.google.id": profile.id).exec (err, user) ->
    return callback(err) if err
    isNew = false
    if req.user
      user = req.user
    if !user
      user = new User(name: profile.displayName)
      isNew = true
      #user.email = if profile.emails.length > 0 then profile.emails[0].value
      user.name = profile.displayName
      user.image = profile._json.profile_image_url
    user.profiles = user.profiles or {}
    user.email = profile.emails[0].value if profile.emails.length > 0
    user.profiles.google = profile
    user.auth_keys= user.auth_keys or {}
    user.auth_keys['google'] =
      key: token
      secret: secret
      refreshToken: req.query.code
    user.getGoogleAccessToken()
    user.markModified "profiles"
    user.markModified "auth_keys"
    Provider.findOne name:"google", (err, google) ->
      return callback(err)  if err
      addProvider = (user, google) ->
        user.providers.addToSet google
        user.save (err, user) ->
          return callback(err)  if err
          next null, user
      if !google
        google = new Provider name: 'google'
        google.save (err, google) ->
          addProvider user, google
      else
        addProvider user, google

UserSchema.static 'authTwitter', (req, token, secret, profile, next) ->
  User.findOne("profiles.twitter.id": profile.id).exec (err, user) ->
    return callback(err) if err
    isNew = false
    if req.user
      user = req.user
    if !user
      user = new User(name: profile.displayName)
      isNew = true
      #user.email = if profile.emails.length > 0 then profile.emails[0].value
      user.name = profile.displayName
      user.image = profile._json.profile_image_url
    user.profiles = user.profiles or {}
    user.profiles.twitter = profile
    user.auth_keys= user.auth_keys or {}
    user.auth_keys['twitter'] =
      key: token
      secret: secret
    user.markModified "profiles"
    user.markModified "auth_keys"
    Provider.findOne name:"twitter", (err, twitter) ->
      return callback(err)  if err
      addProvider = (user, twitter) ->
        user.providers.addToSet twitter
        user.save (err, user) ->
          return callback(err)  if err
          #if isNew
            #mailer.newUser user
          user.streamTweets()
          next null, user
      if !twitter
        twitter = new Provider name: 'twitter'
        twitter.save (err, twitter) ->
          addProvider user, twitter
      else
        addProvider user, twitter

streamers = {}
clients = {}
UserSchema.method 'stopTweetStream', ->
  user = @
  if streamers.twitter?[user.id]
    console.log 'killing old streamer'
    streamers['twitter'][user.id].destroy()
    delete streamers['twitter'][user.id]
  if clients.twitter?[user.id]
    console.log 'killing old client'
    delete clients['twitter'][user.id]

UserSchema.method 'streamTweets', ->
  user = @
  require('./lib/twitter_client') user, (err, twitter) ->
    if err
      return console.log "error making twitter client"
    streamer = require("./lib/twitter_streamer")
    streamers['twitter'] = streamers['twitter'] || {}
    clients['twitter'] = clients['twitter'] || {}
    clients['twitter'][user.id] = twitter
    user.stopTweetStream()
    streamer.start twitter, user, (stream) ->
      streamers['twitter'][user.id] = stream

UserSchema.method 'newTweet', (tweet)->
  req = https.get "#{@.imp_url}color=0000ff", (res) ->
    bodyChunks = []
    res.on("data", (chunk) ->
      bodyChunks.push chunk
    ).on "end", ->
      body = Buffer.concat(bodyChunks)
  req.on "error", (e) ->
    console.log "ERROR: " + e.message

UserSchema.method 'newEmail', (messages)->
  if messages?.unseen > 0
    req = https.get "#{@.imp_url}color=ff0000", (res) ->
      bodyChunks = []
      res.on("data", (chunk) ->
        bodyChunks.push chunk
      ).on "end", ->
        body = Buffer.concat(bodyChunks)
        console.log 'sent to lamp'
    req.on "error", (e) ->
      console.log "ERROR sending to lamp: " + e.message

UserSchema.method 'getGoogleAccessToken', ->
  querystring = require('querystring')
  user = @
  data = querystring.stringify
    client_id:"#{config.google.clientID}"
    client_secret:"#{config.google.clientSecret}"
    code:"#{user.auth_keys.google.refreshToken}"
    grant_type:"authorization_code"

  console.log data

  options =
    hostname: "accounts.google.com"
    path: "/o/oauth2/token"
    method: "POST"
    headers:
      'Content-Type': 'application/x-www-form-urlencoded'
      'Content-Length': Buffer.byteLength(data)

  req = https.request(options, (res) ->
    console.log "statusCode: ", res.statusCode
    console.log "headers: ", res.headers
    res.on "data", (d) ->
      process.stdout.write d
  )
  req.write data
  req.end()
  req.on "error", (e) ->
    console.error e

UserSchema.method 'streamEmails', ->
  console.log 'lets stream some emails'
  user = @
  #user.getGoogleAccessToken()
  #return
  require('./lib/mail_client') user, (err, imap) ->
    if err
      return console.log "error making mail streamer client"
    console.log 'got my imap client'
    streamer = require("./lib/mail_streamer")
    streamers['mail'] = streamers['mail'] || {}
    streamers['mail'][user.id] = imap
    if streamers[user.id]
      console.log 'killing old streamer'
      streamers['mail'][user.id].end()
    streamer.start imap, 10*60, user

TweetSchema = new Schema
  created_at: Date
  tweet_id:
    type: Number
    index:
      unique: true
      dropDups: true

  text: String
  user:
    type: Schema.ObjectId
    ref: 'User'
  link: String
  tags: [String]
,
  capped:
    size: 536870912
    autoIndexId: true
 
TweetSchema.static 'build', (twitter_obj) ->
  self = new @(twitter_obj)
  self.tweet_id = twitter_obj.id
  self.user = twitter_obj.user

  self.tags = _.pluck(twitter_obj.entities.hashtags, "text")
  self

TweetSchema.statics.topFiveTags = (done) ->
  @aggregate
    $project:
      tags: 1
  ,
    $unwind: "$tags"
  ,
    $project:
      tags:
        $toLower: "$tags"
  ,
    $group:
      _id: "$tags"
      count:
        $sum: 1
  ,
    $sort:
      count: -1
  , done
  return

TweetSchema.statics.topFiveTagsNormalized = (done) ->
  @topFiveTags (err, tags) ->
    totalTweats = 0
    i = 0

    while i < tags.length
      totalTweats += tags[i].count
      i++
    i = 0

    while i < tags.length
      tags[i].count = tags[i].count / totalTweats
      i++
    done err, tags
    return

  return

TweetSchema.statics.topFiveTagsFiltered = (hashTags, done) ->
  @aggregate
    $project:
      tags: 1
  ,
    $unwind: "$tags"
  ,
    $project:
      tags:
        $toLower: "$tags"
  ,
    $match:
      tags:
        $in: hashTags
  ,
    $group:
      _id: "$tags"
      count:
        $sum: 1
  ,
    $sort:
      count: -1
  , done
  return

TweetSchema.statics.topFiveTagsNormalizedFiltered = (hashTags, done) ->
  @topFiveTagsFiltered hashTags, (err, tags) ->
    totalTweats = 0
    i = 0

    while i < tags.length
      totalTweats += tags[i].count
      i++
    i = 0

    while i < tags.length
      tags[i].count = tags[i].count / totalTweats
      i++
    done err, tags
    return

  return

TweetSchema.statics.tagLeaderboard = (tag, done) ->
  @aggregate
    $project:
      tags: 1
      user: 1
  ,
    $unwind: "$tags"
  ,
    $project:
      tags:
        $toLower: "$tags"

      user: "$user"
  ,
    $match:
      tags: tag
  ,
    $group:
      _id: "$user"
      count:
        $sum: 1
  ,
    $sort:
      count: -1
  , done
  return

Tweet = exports.Tweet = mongoose.model "Tweet", TweetSchema
User = exports.User = mongoose.model "User", UserSchema
Provider = exports.Provider = mongoose.model "Provider", ProviderSchema

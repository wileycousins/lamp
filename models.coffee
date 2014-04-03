_ = require "underscore"
mongoose = require("mongoose")
https = require("https")

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

UserSchema.static 'authTwitter', (token, secret, profile, next) ->
  User.findOne("profiles.twitter.id": profile.id).exec (err, user) ->
    return callback(err) if err
    isNew = false
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
        console.log user.providers
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
UserSchema.method 'streamTweets', ->
  user = @
  require('./lib/twitter_client') user, (err, twitter) ->
    if err
      return console.log "error making twitter client"
    streamer = require("./lib/twitter_streamer")
    if streamers[user.id]
      console.log 'killing old streamer'
      streamers[user.id].destroy()
    streamer.start twitter, user, (stream) ->
      streamers[user.id] = stream

UserSchema.method 'newTweet', (tweet)->
  req = https.get "#{@.imp_url}color=B7C22C", (res) ->
    bodyChunks = []
    res.on("data", (chunk) ->
      bodyChunks.push chunk
    ).on "end", ->
      body = Buffer.concat(bodyChunks)
  req.on "error", (e) ->
    console.log "ERROR: " + e.message

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

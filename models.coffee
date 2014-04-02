_ = require "underscore"
mongoose = require("mongoose")

Schema = mongoose.Schema

UserSchema = new Schema
  provider: String
  uid: String
  name: String
  image: String
  created:
    type: Date
    default: Date.now
TweetSchema = new Schema(
  created_at: Date
  tweet_id:
    type: Number
    index:
      unique: true
      dropDups: true

  text: String
  user:
    id: Number
    name: String
    image: String
    screen_name: String

  tags: [String]
,
  capped:
    size: 536870912
    autoIndexId: true
)
TweetSchema.statics.build = (twitter_obj) ->
  self = new this(twitter_obj)
  self.tweet_id = twitter_obj.id
  self.user =
    id: twitter_obj.user.id
    name: twitter_obj.user.name
    image: twitter_obj.user.profile_image_url
    screen_name: twitter_obj.user.screen_name

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

exports.Tweet = mongoose.model "Tweet", TweetSchema
exports.User = mongoose.model "User", UserSchema

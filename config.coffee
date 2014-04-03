exports.loggerFormat = "dev"
exports.useErrorHandler = true
exports.enableEmailLogin = true
exports.mongodb = process.env.MONGO_DB || "mongodb://localhost/lamp"
exports.sessionSecret = "super duper bowls"
exports.useLongPolling = process.env.USE_LONG_POLLING || false
exports.emailPW = process.env.EMAIL_PW
exports.url = process.env.SITE_URL || "http://127.0.0.1:3000"
exports.stripe = process.env.STRIPE || 'sk_test_n06Ogoe7k2fAfGwEsLohPmZV'
exports.stripe_js = process.env.STRIPE_JS || "pk_test_DzlAwMEWAF4t32q7ioR5Z0sK"
exports.twitter =
  consumerKey: process.env.TWITTER_CONSUMER_KEY
  consumerSecret: process.env.TWITTER_CONSUMER_SECRET
  callbackURL: "#{exports.url}/auth/twitter/callback"
  passReqToCallback: true

exports.google=
  clientID: process.env.GOOGLE_CLIENT_ID
  clientSecret: process.env.GOOGLE_CLIENT_SECRET
  callbackURL: "#{exports.url}/auth/google/callback"
  passReqToCallback: true

exports.twitter_access =
  ACCESS_KEY: process.env.TWITTER_ACCESS_KEY
  ACCESS_SECRET: process.env.TWITTER_ACCESS_SECRET

exports.gmail =
  USER: process.env.GMAIL_USER
  PASSWORD: process.env.GMAIL_PASSWORD

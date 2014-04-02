exports.loggerFormat = "dev"
exports.useErrorHandler = true
exports.enableEmailLogin = true
exports.mongodb = process.env.MONGO_DB || "mongodb://localhost/lamp"
exports.sessionSecret = "super duper bowls"
exports.useLongPolling = process.env.USE_LONG_POLLING || false
exports.emailPW = process.env.EMAIL_PW
exports.url = process.env.SITE_URL || "http://127.0.0.1:5000"
exports.stripe = process.env.STRIPE || 'sk_test_n06Ogoe7k2fAfGwEsLohPmZV'
exports.stripe_js = process.env.STRIPE_JS || "pk_test_DzlAwMEWAF4t32q7ioR5Z0sK"
exports.twitter=
  CONSUMER_KEY: process.env.TWITTER_CONSUMER_KEY
  CONSUMER_SECRET: process.env.TWITTER_CONSUMER_SECRET

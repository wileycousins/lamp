
config          = require '../config'
models          = require '../models'
User            = models.User
Provider        = models.Provider
_               = require 'underscore'
stripe          = require('stripe')(config.stripe)

exports.show = (req, res) ->
  if req.user
    req.params = req.params || {}
    req.params['id'] = req.user.id
    exports.api.show req, res, (err, user) ->
      if err
        return res.render "error.jade", error: err
      res.args['me'] = user
      res.args['title'] = 'profile'
      Provider.find name: $not: $in: _.pluck(user.providers, "name") , (err, providers) ->
        if err
          return res.render "error.jade", error: err
        res.args['providers'] = providers
        res.render "profile.jade", res.args
  else
    res.redirect "/"

exports.save_thing = (req, res) ->
  if req.user
    req.user.add_saved_thing
      thing: req.body.thing
      venue: req.body.venue
    req.user.save (err, user) ->
      if err
        return res.send err.toString(), 500
      res.send "w00t. saved thing"
  else
    res.send "<h4>You must be logged in</h4><h2><a href='/login'>login now &nbsp;<img src='/images/about-orange.png'/></a></h2>", 401

chargeCard = (charge, req ,res) ->
  user = req.user
  stripe.charges.create charge, (err, charge) ->
    if err
      console.log err
      return res.render "error.jade", is_html: true, error:  "<h3>error creating your purchase record, sorry. try again.</h3><p>if you have problems email <a href='mailto:dev@wileycousins.com'>dev@wileycousins.com</a> and complain</p>"
    purchase = new PurchasedThing
      thing: req.body.thing
      venue: req.body.venue
      user: user
    purchase.save (err, purchase) ->
      user.purchased_things.addToSet purchase
      user.save (err, user) ->
        if err
          return res.send err.toString(), 500
        res.send "w00t. bought thing"
        console.log "save card?"
        console.log req.body['save-card']

chargeCustomer = (req, res) ->
  user = req.user
  total = req.body.total
  console.log req.body
  charge =
    description: "#{user.name} <#{user.email}> @ #{user.address}, #{user.city}, #{user.state}, #{user.zip}"
    amount: total*100
    currency: 'USD'
    card: req.body.stripeToken
    customer: user.stripe_customer.id

  if req.body['save-card']
    console.log "saved card on stripe"
    stripe.customers.createCard user.stripe_customer.id, card:
      number: req.body['cc-number']
      cvc:    req.body['cc-cvc']
      exp_month: req.body['cc-exp-month']
      exp_year: req.body['cc-exp-year']
    , (err, card) ->
      if err
        console.log "error creating stripe card: #{err}"
        return res.send err.toString(), 500
      user.add_card card
      user.markModified "stripe_cards"
      user.save()
      charge.card = card.id
      chargeCard charge, req, res
  else
    chargeCard charge, req, res

exports.buy_thing = (req, res) ->
  if req.user
    user = req.user
    if req.body.stripeToken
      if user.stripe_customer?.id?.length > 0
        console.log "already have customer info"
        chargeCustomer req, res
      else
        console.log "new customer"
        customer = 
          email: user.email
        stripe.customers.create customer, (err, customer) ->
          console.log "made stripe customer"
          if err
            console.log "err creating stripe customer #{err}"
          user.stripe_customer = customer
          user.markModified "customer"
          user.save (err, user) ->
            chargeCustomer req, res
    else
      req.body['stripeToken'] = req.body.payment_type
      chargeCustomer req, res
  else
    res.send "<h4>You must be logged in</h4><h2><a href='/login'>login now &nbsp;<img src='/images/about-orange.png'/></a></h2>", 401

exports.api =
  list: (req, res, next) ->
    User.find()
      .populate 'providers'
      .exec (err, users)->
        if err
          return res.send err
        res.jsonData = users
        next()

  show: (req, res, next) ->
    User.findById(req.params.id)
      .populate 'providers'
      .exec (err, user)->
        if err
          return res.send err
        res.jsonData = user || info: 'Not found'
        next err, user

  create: (req, res, next) ->
    user = new User
      name: req.body.name
      email: req.body.email
      is_merchant: req.body.is_merchant
      is_venue: req.body.is_venue
      is_admin: req.body.is_admin
    user.save (err, user)->
      if err
        return res.send err
      res.jsonData = user || info: 'No user after create and save. this is bad'
      next err, user

  update: (req, res, next) ->
    User.findById(req.params.id).exec (err, user)->
      if err
        return res.send err
      user.name   = req.body.name
      user.email  = req.body.email
      user.phone  = req.body.phone
      user.is_merchant = req.body.is_merchant?
      user.is_venue    = req.body.is_venue?
      user.is_admin    = req.body.is_admin?
      user.add_address_from_body req.body, (err, user) ->
        if err
          return res.send err
        user.save (err, user)->
          if err
            return res.send err
          res.jsonData = user || info: 'No user after update and save. this is bad'
          return next()

  remove: (req, res, next) ->
    User.findById(req.params.id).exec (err, user)->
      if err
        return res.send err
      if user
        user.remove (err) ->
          if err
            return res.send err
          res.jsonData = user || info: 'User removed'
          next()

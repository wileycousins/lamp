
Imap = require("imap")
inspect = require("util").inspect
config = require '../config'

imap = new Imap(
  user: config.gmail.USER
  password: config.gmail.PASSWORD
  host: "imap.gmail.com"
  port: 993
  tls: true
)

inboxStatus = (cb) ->
  imap.status 'INBOX', (err, box)->
    console.log 'updated status'
    console.log box.messages

imap.once "ready", ->
  console.log "imap ready"
  inboxStatus()

imap.once "error", (err) ->
  console.log err
  return

imap.once "end", ->
  console.log "Connection ended"
  return

imap.connect()

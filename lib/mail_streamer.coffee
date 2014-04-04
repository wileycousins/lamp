
module.exports = 
  start: (client, frequency, user) ->
    client.on "new", (msg) ->
      console.log 'new msg'
      user.newEmail msg
  

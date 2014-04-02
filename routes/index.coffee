fs = require("fs")

j = 0

resourceFiles = fs.readdirSync(__dirname)
while j < resourceFiles.length
  
  # raw filename like 'users.js'
  resourceFileName = resourceFiles[j++]
  resourceFilePath = __dirname + "/" + resourceFileName
  
  # remove the file extension so it's just 'users'
  continue  if resourceFileName.match "index" # skip this file
  parts = resourceFileName.split(".")
  continue  unless parts[parts.length - 1] is "coffee" # skip non-javascript files
  resourceName = parts[0]
  
  # exports.ui.users = require('/Users/somebody/my_project/routes/ui/users.js')  <-- what happens
  exports[resourceName] = require(resourceFilePath)

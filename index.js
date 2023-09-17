//now it load express module with `require` directive
var express = require('express')
var app = express()
//Define request response in root URL (/) and response with text Hello World!
app.get('/', function (req, res) {
  res.send('Hello World!')
})
//Launch listening server on port 8080 and consoles the log.
app.listen(8080, function () {
  console.log('app listening on port 8080!')
})
                                            

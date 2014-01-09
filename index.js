var http = require('http')
  , connect = require('connect')
  , PORT = 3000
  , app
;

(app = connect())
  .use(connect.static('public'))
  .use(connect.directory('public'))
;

http.createServer(app).listen(PORT);
console.log('Stream data with Flash ready on %s', PORT);
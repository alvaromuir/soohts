restify   = require 'restify'
bunyan    = require 'bunyan'
routes    = require './routes'
socketio  = require 'socket.io' 
redis     = require 'node-redis'
config    = require './config'

soohts    = config.soohts;
tweetCred = config.twitterCreds
Content   = soohts.models.Content;
serverName= soohts.settings.db[0].toUpperCase()+soohts.settings.db.slice(1)


#Initalize DB Connection
config.soohts.init()

#Twitter stuff
Twitter = require 'twit'
twtr    = new Twitter tweetCred

# Logger setup
log = bunyan.createLogger
  name: serverName + ' RESTful Server'
  level: process.env.LOG_LEVEL || 'warn'
  stream: process.stdout
  serializers: bunyan.stdSerializers

# Server initializer
server = restify.createServer
  name: serverName
  log: log
  version: '0.0.1'

server.use restify.acceptParser server.acceptable
server.use restify.queryParser()
server.use restify.bodyParser()
server.use (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Headers", "X-Requested-With, Content-Type"
  res.header "Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS"
  return next()

# Bunyan
server.on 'after', restify.auditLogger log: log


#Routes
respond =  (req, res, next) ->
  res.send "hello, " + req.params.name

server.opts /\.*/, (req, res, next) ->
  res.send 200
  return next()

server.get "/", routes.index
server.get "/hello/:name", respond
server.head "/hello/:name", respond



# Socket.io 
io = socketio.listen server
io.set 'log level', 1

io.sockets.on 'connection', (socket) ->
  socket.emit 'news', '@alvaromuir says the server is ready.'

  #mo' twitter stuff

  stream = twtr.stream 'statuses/filter', track: 'billboards, out of home'
  stream.on 'tweet', (tweet) ->
    if tweet
      socket.emit 'tweets', tweet  

  twtr.get 'search/tweets', q: 'billboards', count: 10, (err, tweets) ->
    if tweets
      tweets.statuses.forEach (tweet) ->
          socket.emit 'tweets', tweet

  twtr.get 'statuses/user_timeline', screen_name: 'cbsoutdoor', count: 1, (err, tweet) ->
    if tweet
      socket.emit 'tweets', tweet[0] 


server.listen 8000, ->
  console.log '%s listening at %s', server.name, server.url
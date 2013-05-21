restify   = require 'restify'
connect   = require 'connect'
bunyan    = require 'bunyan'
socketio  = require 'socket.io' 
util      = require 'util'

routes    = require './routes'
config    = require './config'
soohtsdb  = config.soohts
serverName= soohtsdb.settings.db[0].toUpperCase()+soohtsdb.settings.db.slice(1)

port      = 8124

#Initalize DB Connection
soohtsdb.init()

# Logger setup
module.exports.appLogger = appLogger = bunyan.createLogger
  name: serverName + ' RESTful Server'
  level: process.env.LOG_LEVEL || 'warn'
  stream: process.stdout
  serializers: bunyan.stdSerializers

# Server initializer
module.exports.server = server = restify.createServer
  name: serverName
  log: appLogger
  version: '0.0.1'

server.use restify.acceptParser server.acceptable
server.use restify.queryParser()
server.use restify.bodyParser()
server.use (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Headers", "X-Requested-With, Content-Type"
  res.header "Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS"
  return next()
server.use restify.fullResponse()

# Bunyan
server.on 'after', restify.auditLogger log: appLogger


#Routes
server.opts /\.*/, (req, res, next) ->
  res.send 200
  return next()

server.get "/", routes.index

server.get "/api/response.json?:queryString", routes.queryFilters

server.get "/api/twitter/stream", (req, res, next) ->
  res.send req.url
  return next()

# Socket.io 
module.exports.io = io = socketio.listen server
io.set 'log level', 1
io.sockets.on 'connection', (socket) ->
    socket.emit 'news', '@alvaromuir says, "The server is ready."'

# Here. We. Go.
server.listen port, ->
  console.log '%s listening at %s', server.name, server.url
///
  DB setup and any external API config
///

mongoose = require 'mongoose'
Twitter = require 'twit'

campaignSchema = mongoose.Schema require './schema'

module.exports =
  soohts:
    settings:
      host: '127.0.0.1'
      db: 'soohts'
      username: ''
      password: ''

    models:
      Campaign: mongoose.model 'Campaign', campaignSchema

    init: ->
      connString = 'mongodb://'
      
      if this.settings.user 
        connString += this.settings.username
      if this.settings.pass 
        connString += ':'+this.settings.pass+'@'
      connString += this.settings.host
      if this.settings.port 
        connString += ':'+this.settings.port

      connString += '/'+this.settings.db
      
      mongoose.connect connString

  twitter: 
    keys:
      consumer_key: 'DHzjdfmE14a0wLvbng3Wxw'
      consumer_secret: 'xHeozURKXBM1ycgilw50n2NV9R58GoznCM4ts0CPE2M'
      access_token: '37232975-bHnl1SJCMwBVKuovFIbNuRtYxPfKCVlzYob7QhQla'
      access_token_secret: 'wWj7UKhbQF58TDD7jc0ExpLdAfk60DEAKBNTiLUrb0'
    init: ->
      new Twitter this.keys
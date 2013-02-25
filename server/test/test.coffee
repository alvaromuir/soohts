chai    = require "chai"
expect = chai.expect
assert  = chai.assert
should  = chai.should
request = require "request"
app     = require "../server"

baseUrl = 'http://localhost:8000/'

describe "REST", ->
  describe "app server", ->
    describe "when receiving connection requests", ->
      it 'should return twitter url response', (done) ->
        testQuery = 'oaaa'
        request baseUrl + 'api/response.json?q=' + testQuery, (err, res, body) ->
          if err
            done(err)
            return
          rslts = JSON.parse body
          (expect rslts.query).to.equal testQuery.split(' ').join '+'
          (expect rslts).to.be.an "object"
          done()
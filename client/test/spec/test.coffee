
'use strict';
$ =  jQuery()
describe 'The WebApp', ->
  it 'should have a namespaced \'app\' object', (done) ->
  	$ ->
  		(expect app).to.be.an('object')
  		(expect 1+1).to.equal(3)
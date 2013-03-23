#global define

'use strict'
@app = window.app ? {}

define ['jquery', 'underscore', 'twitter', 'maps', 'form-clean'], ($, _, twitter, maps, formCleaner) ->

	maps.setGlobalUserGeo
		lat: 40.7522
		lng: -73.9755

	# form variables
	$keywords   = $ '#keywords'
	$count      = $ '#quantity'
	$locations  = $ '#locations'
	$radius     = $ '#radius'
	$rsltsText  = $ '#results-header'
	$submit     = $ '#submit-btn'
	$well       = $ '#tweet-well'
	$map        = $ '#map_canvas'
	radValue    = {}
	
	$submit.on 'click', ->
		queryObj = {}
		radValue = formCleaner.setQueryRadius $radius.val().trim()

		queryObj.q = formCleaner.setQueryKeywords $keywords.val().trim()

		if formCleaner.contentExists $locations
			if _.include $locations.val().trim(), 'My Current Location'
				queryObj.geocode = app.userGeo.lat +','+ app.userGeo.lng +','+ radValue.miles +'mi'
				$(document).trigger 'app.queryObjResults', queryObj
			else
				formCleaner.setQueryLocation $locations.val().trim(), (rslts) ->
					queryObj.geocode = rslts.lat + ',' + rslts.lng + ',' +  radValue.miles + 'mi'
					$(document).trigger 'app.queryObjResults', queryObj

		else
			$(document).trigger 'app.queryObjResults', queryObj

		if formCleaner.contentExists($keywords) == false and formCleaner.contentExists($locations) == false and formCleaner.contentExists($radius) == false
			$rsltsText.show().html 'Results for CBS Outdoor related Tweets :'

		if formCleaner.contentExists($keywords) == false and _.trim $('#locations').val(), '"' == 'My Current Location' and formCleaner.contentExists($radius) == false
			$rsltsText.show().html 'Results for CBS Outdoor related Tweets near me :'

		return false


	$(document).on 'app.queryObjResults', (e, queryObj) ->
		if queryObj.geocode
			rslts = 
				lat: queryObj.geocode.split(',')[0]
				lng: queryObj.geocode.split(',')[1]
		else
			rslts = 
				lat: app.userGeo.lat
				lng: app.userGeo.lng

		$map.show()

		app.rsltMap = maps.createMap 'map_canvas', rslts.lat, rslts.lng
		maps.genRadius app.rsltMap, 
			radius: radValue.meters
			center: app.rsltMap.getCenter()

		if parseInt $count.val().trim(), 10
			queryObj.rpp = $count.val()
		else
			queryObj.rpp = 15

		twitter.getTweets queryObj, (tweets) ->
			_.each tweets, (tweet) ->
				twitter.cleanTweet tweet.attributes, (rslt) ->
					twitter.mapTweet rslt, app.rsltMap
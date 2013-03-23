# Twitter methods

'use strict'
@app = window.app ? {}

define ['jquery', 'collections', 'handlebars'], ($, collections) ->
    app.twitter =
        getTweets: (queryObj, cb) ->
            app.Tweets.fetch
                data: queryObj
                success: ->
                      window.tweets = app.Tweets.models
                      cb tweets
                      return tweets

        cleanTweet: (obj, cb) ->
            rslt =
                userId: obj.from_user_id
                username: '@' + obj.from_user
                name: obj.from_user_name
                thumb: obj.profile_image_url_https
                profile: 'https://twitter.com/' + obj.from_user
                msgId: obj.id
                text: obj.text
                tweetUrl: 'https://twitter.com/' + obj.from_user_name + 'status/'+ obj.id
                geo: obj.geo
                location: obj.location
            cb rslt
            return rslt

        mapTweet: (obj, map) ->
            infoWindowData = Handlebars.compile($('#tweet-map-template').html())(obj)
            if obj.geo
                coords =
                      lat: obj.geo.coordinates[0]
                      lng: obj.geo.coordinates[1]
                app.maps.addMarkers map, coords, infoWindowData
                return

            else
                app.utils.geocodeAddress obj.location, (coords) ->
                    app.maps.addMarkers map, coords, infoWindowData 
                    return

    return app.twitter
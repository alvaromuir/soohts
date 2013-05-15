# Twitter methods

'use strict'
@app = window.app ? {}

define ['jquery','moment', 'collections', 'handlebars'], ($, moment, collections) ->
    # Handlebars helpers
    Handlebars.registerHelper 'daystamp', (input) ->
        return moment(input).format('MMMM Do, YYYY')

    Handlebars.registerHelper 'when', (input) ->
        return moment(input).fromNow()

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
                timestamp: obj.created_at
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

        tableTweet: (obj, table) ->
            rsltsTableRow = Handlebars.compile($('#tweet-results-row').html())(obj)
            table.append rsltsTableRow

    return app.twitter
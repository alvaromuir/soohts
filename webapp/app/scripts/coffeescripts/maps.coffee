#Google Maps utilities

'use strict'
@app = window.app ? {}

define ['jquery', 'googleMaps'], ($) ->
  if window.google.maps
    app.maps =
        createMap: (div, lat, lng) ->
            options =
                center: new google.maps.LatLng lat,lng
                zoom: 15
                mapTypeId: google.maps.MapTypeId.ROADMAP

            googMap = new google.maps.Map document.getElementById(div), options

            newZoom = null
            google.maps.event.addListenerOnce googMap, 'bounds_changed', ->
                if newZoom != googMap.getZoom()
                    newZoom = googMap.getZoom()+1

            googMap.setZoom newZoom
            return googMap

        genRadius: (gMap, options) ->
            rad =  new google.maps.Circle options
            gMap.fitBounds rad.getBounds()

        codeAddress: (address, cb) ->
            geocoder = new google.maps.Geocoder()
            if typeof address == 'object'
                geocoder.geocode
                    'latLng': address
                , (results, status) ->
                    if status is google.maps.GeocoderStatus.OK
                        console.lo results
                    else
                        console.log 'error searching latlng'

            else
                geocoder.geocode
                    'address': address
                , (results, status) ->
                    geoData = {}
                    if status is google.maps.GeocoderStatus.OK
                        geoData = results[0] if results.length = 1
                        geoData.lat = geoData.geometry.location.lat()
                        geoData.lng = geoData.geometry.location.lng()
                        cb geoData
                        return

                        _(results).each (v, k) ->
                            address_components = results[k].address_components
                            if address_components[3]
                                short_name = address_components[3].short_name
                                geoData = results[k] if _.find(app.utils.states(), abbreviation: short_name)
                                if geoData.geometry.location
                                    geoData.lat = geoData.geometry.location.lat()
                                    geoData.lng = geoData.geometry.location.lng()
                        cb geoData
                    else
                        if app.userGeo.lat
                            geoData.lat   = app.userGeo.lat
                            geoData.lng   = app.userGeo.lng
                            cb geoData
                            return
                        else
                            geoData.lat   = 40.7522
                            geoData.lng   = -73.9755
                            cb geoData
                            return
                    return

            return

        setGlobalUserGeo: (geoObj) ->
            app.userGeo = geoObj ? {}

            if Modernizr.geolocation
                navigator.geolocation.getCurrentPosition (position) ->
                    if position.coords.latitude and position.coords.longitude
                        app.userGeo = 
                            lat: position.coords.latitude
                            lng: position.coords.longitude
            return

        addMarkers: (gMap, pos, info) ->
            coord = new google.maps.LatLng(pos.lat, pos.lng)

            infoWindow = new google.maps.InfoWindow
                content: info

            marker = new google.maps.Marker
                position: coord
                map: gMap

            google.maps.event.addListener marker, 'click', ->
                if app.rsltMap.infoMarker
                    app.rsltMap.infoMarker.close()
                app.rsltMap.infoMarker = infoWindow
                infoWindow.open(gMap, marker)

            return marker


    app.utils.geocodeAddress = app.maps.codeAddress
    app.utils.setUsersGeo    = app.maps.setGlobalUserGeo
    return app.maps
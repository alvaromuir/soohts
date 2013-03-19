///
 Google Maps utilities
 Alvro Muir, CBS Outdoor - @alvaromuir
///

@app = window.app ? {}

define ['jquery', 'googleMaps'], ($) ->
  'use strict'
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

        geocoder.geocode
          'address': address
        , (results, status) ->
          rslts = {}
          if status == google.maps.GeocoderStatus.OK
            if results[0].geometry.location.hb
              rslts.lat   = results[0].geometry.location.hb
            else
              rslts.lat   = results[0].geometry.location.mb

            if results[0].geometry.location.ib
              rslts.lng   = results[0].geometry.location.ib
            else
              rslts.lng   = results[0].geometry.location.nb
            cb rslts
            return
          else
            if app.userGeo.lat
              rslts.lat   = app.userGeo.lat
              rslts.lng   = app.userGeo.lng
              cb rslts
              return
            else
              rslts.lat   = 40.7522
              rslts.lng   = -73.9755
              cb rslts
              return
        return

      setGlobalUserGeo: (geoObj) ->
        app.userGeo = geoObj if geoObj

        if Modernizr.geolocation
          navigator.geolocation.getCurrentPosition (position) ->
            app.userGeo = 
              lat:  position.coords.latitude
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
          gMap.infoMarker = infoWindow
          infoWindow.open(gMap, marker)

        return marker


  app.utils.geocodeAddress = app.maps.codeAddress
  app.utils.setUsersGeo    = app.maps.setGlobalUserGeo
  return app.maps
(function() {
  /GoogleMapsutilitiesAlvroMuir,CBSOutdoor-@alvaromuir/;

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery', 'googleMaps'], function($) {
    'use strict';
    if (window.google.maps) {
      app.maps = {
        createMap: function(div, lat, lng) {
          var googMap, newZoom, options;
          options = {
            center: new google.maps.LatLng(lat, lng),
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          googMap = new google.maps.Map(document.getElementById(div), options);
          newZoom = null;
          google.maps.event.addListenerOnce(googMap, 'bounds_changed', function() {
            if (newZoom !== googMap.getZoom()) {
              return newZoom = googMap.getZoom() + 1;
            }
          });
          googMap.setZoom(newZoom);
          return googMap;
        },
        genRadius: function(gMap, options) {
          var rad;
          rad = new google.maps.Circle(options);
          return gMap.fitBounds(rad.getBounds());
        },
        codeAddress: function(address, cb) {
          var geocoder;
          geocoder = new google.maps.Geocoder();
          geocoder.geocode({
            'address': address
          }, function(results, status) {
            var rslts;
            rslts = {};
            if (status === google.maps.GeocoderStatus.OK) {
              if (results[0].geometry.location.hb) {
                rslts.lat = results[0].geometry.location.hb;
              } else {
                rslts.lat = results[0].geometry.location.mb;
              }
              if (results[0].geometry.location.ib) {
                rslts.lng = results[0].geometry.location.ib;
              } else {
                rslts.lng = results[0].geometry.location.nb;
              }
              cb(rslts);
            } else {
              if (app.userGeo.lat) {
                rslts.lat = app.userGeo.lat;
                rslts.lng = app.userGeo.lng;
                cb(rslts);
              } else {
                rslts.lat = 40.7522;
                rslts.lng = -73.9755;
                cb(rslts);
              }
            }
          });
        },
        setGlobalUserGeo: function(geoObj) {
          if (geoObj) {
            app.userGeo = geoObj;
          }
          if (Modernizr.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              return app.userGeo = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
              };
            });
          }
        },
        addMarkers: function(gMap, pos, info) {
          var coord, infoWindow, marker;
          coord = new google.maps.LatLng(pos.lat, pos.lng);
          infoWindow = new google.maps.InfoWindow({
            content: info
          });
          marker = new google.maps.Marker({
            position: coord,
            map: gMap
          });
          google.maps.event.addListener(marker, 'click', function() {
            if (app.rsltMap.infoMarker) {
              app.rsltMap.infoMarker.close();
            }
            gMap.infoMarker = infoWindow;
            return infoWindow.open(gMap, marker);
          });
          return marker;
        }
      };
    }
    app.utils.geocodeAddress = app.maps.codeAddress;
    app.utils.setUsersGeo = app.maps.setGlobalUserGeo;
    return app.maps;
  });

}).call(this);

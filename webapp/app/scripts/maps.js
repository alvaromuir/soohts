(function() {
  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery', 'googleMaps'], function($) {
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
          if (typeof address === 'object') {
            geocoder.geocode({
              'latLng': address
            }, function(results, status) {
              if (status === google.maps.GeocoderStatus.OK) {
                return console.lo(results);
              } else {
                return console.log('error searching latlng');
              }
            });
          } else {
            geocoder.geocode({
              'address': address
            }, function(results, status) {
              var geoData;
              geoData = {};
              if (status === google.maps.GeocoderStatus.OK) {
                if (results.length = 1) {
                  geoData = results[0];
                }
                geoData.lat = geoData.geometry.location.lat();
                geoData.lng = geoData.geometry.location.lng();
                cb(geoData);
                return;
                _(results).each(function(v, k) {
                  var address_components, short_name;
                  address_components = results[k].address_components;
                  if (address_components[3]) {
                    short_name = address_components[3].short_name;
                    if (_.find(app.utils.states(), {
                      abbreviation: short_name
                    })) {
                      geoData = results[k];
                    }
                    if (geoData.geometry.location) {
                      geoData.lat = geoData.geometry.location.lat();
                      return geoData.lng = geoData.geometry.location.lng();
                    }
                  }
                });
                cb(geoData);
              } else {
                if (app.userGeo.lat) {
                  geoData.lat = app.userGeo.lat;
                  geoData.lng = app.userGeo.lng;
                  cb(geoData);
                  return;
                } else {
                  geoData.lat = 40.7522;
                  geoData.lng = -73.9755;
                  cb(geoData);
                  return;
                }
              }
            });
          }
        },
        setGlobalUserGeo: function(geoObj) {
          app.userGeo = geoObj != null ? geoObj : {};
          if (Modernizr.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              if (position.coords.latitude && position.coords.longitude) {
                return app.userGeo = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
                };
              }
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
            app.rsltMap.infoMarker = infoWindow;
            return infoWindow.open(gMap, marker);
          });
          return marker;
        }
      };
      app.utils.geocodeAddress = app.maps.codeAddress;
      app.utils.setUsersGeo = app.maps.setGlobalUserGeo;
      return app.maps;
    }
  });

}).call(this);

(function() {
  /afewlinestotidyuptheimputfilter-form,andmethodstoreturninputdata/;

  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  app.buildMap = true;

  app.locVal = '';

  define(['jquery'], function($) {
    var $chkLocal, $keywords, $locations, $map, $radius, $report, $reset, $rsltsText, utils;
    $keywords = $('#keywords');
    $locations = $('#locations');
    $radius = $('#radius');
    $rsltsText = $('#results-header');
    $chkLocal = $('input[name=local]');
    $reset = $('#reset-btn');
    $map = $('#map_canvas');
    $report = $('#report');
    utils = {
      setQueryKeywords: function(qKywrds) {
        var qKeywords;
        return qKeywords = encodeURIComponent(qKywrds.toString() || '');
      },
      setQueryRadius: function(qRad) {
        var qRadius, rslts;
        if (isNaN(parseFloat(qRad))) {
          qRadius = 1;
        } else {
          qRadius = parseFloat(qRad);
        }
        rslts = {
          miles: qRadius,
          meters: 1609.344 * qRadius
        };
        return rslts;
      },
      setQueryLocation: function(qLoc, cb) {
        return app.utils.geocodeAddress(qLoc.toString().trim(), function(rslts) {
          cb(rslts);
          return rslts;
        });
      },
      contentExists: function(div) {
        'use strict';
        return $(div).val().length > 0;
      }
    };
    $reset.on('click', function() {
      app.utils.setUsersGeo();
      $(this).closest('form').find('input[type=text], textarea').val('');
      $rsltsText.fadeToggle();
      $map.fadeToggle();
      $report.fadeToggle();
      return false;
    });
    $keywords.on('keyup', function() {
      $rsltsText.show();
      if (utils.contentExists($locations) && utils.contentExists($radius)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($(this).val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $locations.val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $radius.val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of ' + $locations.val().trim() + ':');
        } else {
          $rsltsText.html('Random results ');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $locations.val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $radius.val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of ' + $locations.val().trim() + ':');
        }
      }
      if (utils.contentExists($locations) && utils.contentExists($radius) === false) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($(this).val().trim());
          $rsltsText.append(' near ' + $locations.val().trim() + ':');
        } else {
          $rsltsText.html('Random results ');
          $rsltsText.append(' near ' + $locations.val().trim() + ':');
        }
      }
      if (utils.contentExists($locations) === false && utils.contentExists($radius)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($(this).val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' anywhere :');
            return;
          }
          $rsltsText.append(' within ' + $radius.val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            $rsltsText.append(' of you :');
          }
        } else {
          $rsltsText.html('Random results ');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near you :');
            return;
          }
          $rsltsText.append(' within ' + $radius.val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of you :');
        }
      }
      if (utils.contentExists($locations) === false && utils.contentExists($radius) === false) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($(this).val().trim());
          return $rsltsText.append(' anywhere :');
        } else {
          return $rsltsText.empty();
        }
      }
    });
    $locations.on('keyup', function() {
      $rsltsText.show();
      if (utils.contentExists($keywords) && utils.contentExists($radius)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $(this).val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $(radius).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            $rsltsText.append(' of ' + $(this).val().trim() + ':');
          }
        } else {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' anywhere :');
            return;
          }
          $rsltsText.append(' within ' + $(radius).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of you :');
        }
      }
      if (utils.contentExists($keywords) && utils.contentExists($radius) === false) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          $rsltsText.append(' near ' + $(this).val().trim() + ':');
        } else {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          $rsltsText.append(' anywhere :');
        }
      }
      if (utils.contentExists($keywords) === false && utils.contentExists($radius)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Random results');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $(this).val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $(radius).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of ' + $(this).val().trim() + ':');
        } else {
          $rsltsText.html('Random results');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $(this).val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $(radius).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
          }
          $rsltsText.append(' of you :');
        }
      }
      if (utils.contentExists($keywords) === false && utils.contentExists($radius) === false) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Random results');
          return $rsltsText.append(' near ' + $(this).val().trim() + ':');
        } else {
          return $rsltsText.empty();
        }
      }
    });
    $radius.on('keyup', function() {
      $rsltsText.show();
      if (utils.contentExists($keywords) && utils.contentExists($locations)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $locations.val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $(this).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            $rsltsText.append(' of ' + $locations.val().trim() + ':');
          }
        } else {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          $rsltsText.append(' near ' + $locations.val().trim() + ':');
        }
      }
      if (utils.contentExists($keywords) && utils.contentExists($locations) === false) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near you :');
            return;
          }
          $rsltsText.append(' within ' + $(this).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            $rsltsText.append(' of you :');
          }
        } else {
          $rsltsText.html('Results for ');
          $rsltsText.append($keywords.val().trim());
          $rsltsText.append(' anywhere :');
        }
      }
      if (utils.contentExists($keywords) === false && utils.contentExists($locations)) {
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Random results');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' near ' + $locations.val().trim() + ':');
            return;
          }
          $rsltsText.append(' within ' + $(this).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            $rsltsText.append(' of ' + $locations.val().trim() + ':');
          }
        } else {
          $rsltsText.html('Random results');
          $rsltsText.append(' near ' + $locations.val().trim() + ':');
        }
      }
      if (utils.contentExists($keywords) === false && utils.contentExists($locations) === false) {
        app.buildMap = true;
        if ($(this).val().trim().length > 0) {
          $rsltsText.html('Random results');
          if ($radius.val().trim() === '0' || isNaN(parseInt($radius.val().trim()))) {
            $rsltsText.append(' anywhere :');
            return;
          }
          $rsltsText.append(' within ' + $(this).val().trim() + ' mile');
          if ($radius.val().trim() !== '1') {
            $rsltsText.append('s');
            return $rsltsText.append(' of you :');
          }
        } else {
          return $rsltsText.empty();
        }
      }
    });
    $chkLocal.click(function() {
      if ($(this).is(':checked')) {
        app.locVal = $locations.val();
        $locations.val('"My Current Location"');
        return $locations.css("color", "#c00");
      } else {
        $locations.val(app.locVal);
        return $locations.css("color", "#666");
      }
    });
    return app.utils.form_utils = utils;
  });

}).call(this);

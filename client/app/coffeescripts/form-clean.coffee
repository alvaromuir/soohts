///
 a few lines to tidy up the imput filter-form,
 and methods to return input data
///

@app = window.app ? {}

define ['jquery'], ($) ->
  'use strict'
  $keywords   = $ '#keywords'
  $locations  = $ '#locations'
  $radius     = $ '#radius'
  $rsltsText  = $ '#results-header'
  $chkLocal   = $ 'input[name=local]'
  $reset      = $ '#reset-btn'

  utils = 
    setQueryKeywords: (qKywrds) ->
      return qKeywords = encodeURIComponent qKywrds.toString() or 'cbsoutdoor'

    setQueryRadius: (qRad) ->
      if isNaN parseFloat qRad
        qRadius = 1
      else
        qRadius = parseFloat qRad
        
      rslts = 
        miles: qRadius
        meters: 1609.344 * qRadius
      return rslts

    setQueryLocation: (qLoc, cb) ->
      app.utils.geocodeAddress qLoc.toString().trim(), (rslts) ->
        cb rslts
        return rslts

    contentExists: (div) ->
      'use strict'
      return $(div).val().length > 0


  $reset.on 'click',  ->
    app.utils.setUsersGeo()
    $(this).closest('form').find('input[type=text], textarea').val('');
    $rsltsText.fadeToggle()
    $('#map_canvas').fadeToggle()

    return false

  $keywords.on 'keyup', ->
    $rsltsText.show()
    if utils.contentExists($locations) and utils.contentExists($radius)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $(this).val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $locations.val().trim() + ':'
          return

        $rsltsText.append ' within ' + $radius.val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $locations.val().trim() + ':'
      else
        $rsltsText.html 'Random results '

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $locations.val().trim() + ':'
          return

        $rsltsText.append ' within ' + $radius.val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $locations.val().trim() + ':'

    if utils.contentExists($locations) and utils.contentExists($radius) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $(this).val().trim()
        $rsltsText.append ' near ' + $locations.val().trim() + ':'
      else
        $rsltsText.html 'Random results '
        $rsltsText.append ' near ' + $locations.val().trim() + ':'

    if utils.contentExists($locations) == false and utils.contentExists($radius)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $(this).val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' anywhere :'
          return

        $rsltsText.append ' within ' + $radius.val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'
      else
        $rsltsText.html 'Random results '

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near you :'
          return

        $rsltsText.append ' within ' + $radius.val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'

    if utils.contentExists($locations) == false and utils.contentExists($radius) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $(this).val().trim()
        $rsltsText.append ' anywhere :'
      else
        $rsltsText.empty()

  $locations.on 'keyup',  ->
    $rsltsText.show()
    if utils.contentExists($keywords) and utils.contentExists($radius)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $(this).val().trim() + ':'
          return

        $rsltsText.append ' within ' + $(radius).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $(this).val().trim() + ':'
      else
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' anywhere :'
          return

        $rsltsText.append ' within ' + $(radius).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'

    if utils.contentExists($keywords) and utils.contentExists($radius) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()
        $rsltsText.append ' near ' + $(this).val().trim() + ':'
      else
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim() 
        $rsltsText.append ' anywhere :'

    if utils.contentExists($keywords) == false and utils.contentExists($radius)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Random results'

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $(this).val().trim() + ':'
          return

        $rsltsText.append ' within ' + $(radius).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $(this).val().trim() + ':'
      else
        $rsltsText.html 'Random results'

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $(this).val().trim() + ':'
          return

        $rsltsText.append ' within ' + $(radius).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'

    if utils.contentExists($keywords) == false and utils.contentExists($radius) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Random results'
        $rsltsText.append ' near ' + $(this).val().trim() + ':'
      else
        $rsltsText.empty()

  $radius.on 'keyup',  ->
    $rsltsText.show()
    if utils.contentExists($keywords) and utils.contentExists($locations)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $locations.val().trim() + ':'
          return

        $rsltsText.append ' within ' + $(this).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $locations.val().trim() + ':'
      else
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()
        $rsltsText.append ' near ' + $locations.val().trim() + ':'
              
    if utils.contentExists($keywords) and utils.contentExists($locations) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near you :'
          return

        $rsltsText.append ' within ' + $(this).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'
      else
        $rsltsText.html 'Results for '
        $rsltsText.append $keywords.val().trim()
        $rsltsText.append ' near you :'

    if utils.contentExists($keywords) == false and utils.contentExists($locations)
      if $(this).val().trim().length > 0
        $rsltsText.html 'Random results'

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near ' + $locations.val().trim() + ':'
          return

        $rsltsText.append ' within ' + $(this).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of ' + $locations.val().trim() + ':'
      else
        $rsltsText.html 'Random results'
        $rsltsText.append ' near ' + $locations.val().trim() + ':'

    if utils.contentExists($keywords) == false and utils.contentExists($locations) == false
      if $(this).val().trim().length > 0
        $rsltsText.html 'Random results'

        if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
          $rsltsText.append ' near you :'
          return

        $rsltsText.append ' within ' + $(this).val().trim() + ' mile'
        if $radius.val().trim() != '1'
          $rsltsText.append 's'
        $rsltsText.append ' of you :'
      else
        $rsltsText.empty()

  $chkLocal.click ->
    if $(this).is ':checked'
      $locations.val '"My Current Location"'
    else
      $locations.val ''


  app.utils.form_utils = utils
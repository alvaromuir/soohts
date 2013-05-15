///
 a few lines to tidy up the imput filter-form,
 and methods to return input data
///

'use strict'
@app = window.app ? {}
app.buildMap = true 
app.locVal = ''

define ['jquery'], ($) ->
    $keywords   = $ '#keywords'
    $locations  = $ '#locations'
    $radius     = $ '#radius'
    $rsltsText  = $ '#results-header'
    $chkLocal   = $ 'input[name=local]'
    $reset      = $ '#reset-btn'
    $map        = $ '#map_canvas'
    $report     = $ '#report'

    utils = 
        setQueryKeywords: (qKywrds) ->
            return qKeywords = encodeURIComponent qKywrds.toString() or ''

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
        $map.fadeToggle()
        $report.fadeToggle()
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
            # app.buildMap = false
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
            # app.buildMap = false
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
            # app.buildMap = false
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
            # app.buildMap = false
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
                $rsltsText.append ' anywhere :'

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
            # app.buildMap = false
            app.buildMap = true #see app.js for explaination. draws map if locations are selected.
            if $(this).val().trim().length > 0
                $rsltsText.html 'Random results'

                if $radius.val().trim()  == '0' or isNaN parseInt $radius.val().trim()
                    $rsltsText.append ' anywhere :'
                    return

                $rsltsText.append ' within ' + $(this).val().trim() + ' mile'
                if $radius.val().trim() != '1'
                    $rsltsText.append 's'
                    $rsltsText.append ' of you :'

            else
                $rsltsText.empty()

    $chkLocal.click ->
        if $(this).is ':checked'
            app.locVal = $locations.val()
            $locations.val '"My Current Location"'
            $locations.css "color", "#c00"
        else
            $locations.val app.locVal
            $locations.css "color", "#666"

    app.utils.form_utils = utils
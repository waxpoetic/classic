class WaxPoetic.ApplicationController extends Em.Controller
  +observer currentPath
  currentPathChanged: ->
    Ember.run.next ->
      unless Ember.isNone ga
        page = if window.location.hash.length > 0
          window.location.hash.substring 1
        else
          window.location.pathname
        ga 'send', 'pageview', page

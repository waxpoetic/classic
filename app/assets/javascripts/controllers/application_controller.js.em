class WaxPoetic.ApplicationController extends Em.Controller
  +observer currentPath
  currentPathChanged: ->
    Ember.run.next ->
      unless Ember.isNone _ga
        page = if window.location.hash.length > 0
          window.location.hash.substring 1
        else
          window.location.pathname
        _ga.push ['_trackPageView', page]

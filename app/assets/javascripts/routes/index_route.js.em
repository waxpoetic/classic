class WaxPoetic.IndexRoute extends Em.Route
  setupController: (controller) ->
    controller.releases = WaxPoetic.Release.find()

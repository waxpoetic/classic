class WaxPoetic.HomeRoute extends Em.Route
  setupController: (controller) -> controller.releases = WaxPoetic.Release.find()

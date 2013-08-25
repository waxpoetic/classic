class WaxPoetic.ReleasesShowRoute extends Em.Route
  model: (params) -> WaxPoetic.Release.find params.id

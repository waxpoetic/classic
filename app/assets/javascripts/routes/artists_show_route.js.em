class WaxPoetic.ArtistsShowRoute extends Em.Route
  model: (params) -> WaxPoetic.Artist.find params.id

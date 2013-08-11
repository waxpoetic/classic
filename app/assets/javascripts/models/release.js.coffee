# for more details see: http://emberjs.com/guides/models/defining-models/

WaxPoetic.Release = DS.Model.extend
  name: DS.attr 'string'
  releasedOn: DS.attr 'date'
  catalogNumber: DS.attr 'string'
  artist: DS.belongsTo 'WaxPoetic.Artist'
  description: DS.attr 'string'
  tracks: DS.attr 'string'

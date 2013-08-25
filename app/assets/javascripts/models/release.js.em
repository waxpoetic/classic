# for more details see: http://emberjs.com/guides/models/defining-models/

class WaxPoetic.Release extends DS.Model
  name: DS.attr 'string'
  artistName: DS.attr 'string'
  releasedOn: DS.attr 'date'
  catalogNumber: DS.attr 'string'
  artist: DS.belongsTo 'WaxPoetic.Artist'
  description: DS.attr 'string'
  tracks: DS.attr 'string'
  permalink: DS.attr 'string'
  cover: DS.attr 'string'
  notes: DS.attr 'string'

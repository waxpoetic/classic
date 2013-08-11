# for more details see: http://emberjs.com/guides/models/defining-models/

WaxPoetic.Artist = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  members: DS.attr 'string'

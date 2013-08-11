# for more details see: http://emberjs.com/guides/models/defining-models/

class WaxPoetic.Artist extends DS.Model
  name: DS.attr 'string'
  description: DS.attr 'string'
  members: DS.attr 'string'

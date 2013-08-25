WaxPoetic.Product = DS.Model.extend
  name: DS.attr('string')
  file: DS.attr('string')
  license: DS.attr('string')
  price: DS.attr('number')
  release: DS.attr('references')

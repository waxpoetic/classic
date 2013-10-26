Ember.testing = true
Ember.run => @WaxPoetic = Ember.Application.create()

@WaxPoetic.Store = DS.Store.extend \
  revision: 13
  adapter: DS.FixtureAdapter.extend simulateRemoteResponse: false

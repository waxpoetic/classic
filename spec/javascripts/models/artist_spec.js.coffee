#= require spec_helper

describe 'Artist', ->
  before ->
    @artist = new WaxPoetic.Artist()

  it "is not nil", ->
    expect(@artist).to.be.a 'WaxPoetic.Artist'

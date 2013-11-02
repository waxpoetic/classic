#= require spec_helper

describe 'Artist', ->
  before ->
    @artist = new WaxPoetic.Artist()

  it "is truthy", ->
    expect(@artist).to.be.ok

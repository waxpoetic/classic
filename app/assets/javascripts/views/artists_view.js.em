# for more details see: http://emberjs.com/guides/views/

class WaxPoetic.ArtistsView extends Ember.View
  templateName: 'artists'
  didInsertElement: ->
    $(document).on 'mouseenter', '#artists li', ->
      $(this).find('.overlay').fadeIn 250
      $(this).find('.text').fadeIn 250
    $(document).on 'mouseleave', '#artists li', ->
      $(this).find('.overlay').fadeOut 250
      $(this).find('.text').fadeOut 250

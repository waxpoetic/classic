class WaxPoetic.PlaceholderImageView extends Em.View
  template: null
  templateName: null
  attributeBindings: ['src', 'text:alt']
  tagName: 'img'
  src: ~> "http://placehold.it/#{@width}x#{@height}&text=#{@text}"

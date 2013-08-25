Ember.Handlebars.registerBoundHelper 'markdown', (text) ->
  markdown = new Showdown.converter()
  Ember.Handlebars.SafeString markdown.makeHtml(text)

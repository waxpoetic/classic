Ember.Handlebars.registerBoundHelper 'markdown', (text) ->
  markdown = new Showdown.converter()
  new Ember.Handlebars.SafeString markdown.makeHtml(text)

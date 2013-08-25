Ember.Handlebars.registerBoundHelper 'markdown', (text) ->
  markdown = new Showdown.converter()
  new Ember.Handlebars.SafeString "<div class=\"markdown\">#{markdown.makeHtml(text)}</div>"

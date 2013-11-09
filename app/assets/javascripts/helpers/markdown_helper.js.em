Ember.Handlebars.registerBoundHelper 'markdown', (text) ->
  return new Ember.Handlebars.SafeString "" unless text.length > 0
  markdown = new Showdown.converter()
  new Ember.Handlebars.SafeString "<div class=\"markdown\">#{markdown.makeHtml(text)}</div>"

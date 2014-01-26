
# Use cookie storage for session data, unless we're on production.

unless Rails.env.production?
  WaxPoetic::Application.config.session_store :cookie_store, \
    key: '_wax_poetic_session'
end

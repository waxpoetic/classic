# For more information see: http://emberjs.com/guides/routing/

WaxPoetic.Router.map () ->
  @resource 'artists', path: '/artists'
  @resource 'releases', path: '/releases'
  @resource 'artist', { path: '/artists/:name' }, ->
    @resource 'artist_releases', path: 'releases'
  @route 'about', path: '/about'
  @route 'contact', path: '/contact'
  @route 'artists', path: ''

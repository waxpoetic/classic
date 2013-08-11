# For more information see: http://emberjs.com/guides/routing/

WaxPoetic.Router.map () ->
  @resource 'artists', path: '/artists'
  @resource 'releases', path: '/releases'
  @resource 'artist', { path: '/artists/:name' }, ->
    @resource 'releases', path: 'releases'
  @route 'artists', path: ''

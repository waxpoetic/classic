# For more information see: http://emberjs.com/guides/routing/

WaxPoetic.Router.map () ->
  @resource 'artists', path: '/artists'
  @resource 'releases', { path: '/releases' }, ->
    @route 'show', path: ':id'
  @resource 'artists', { path: '/artists' }, ->
    @resource 'artist', { path: ':name' }, ->
      @resource 'artist_releases', path: 'releases'
  @route 'about', path: '/about'
  @route 'contact', path: '/contact'
  @route 'shop', path: '/shop'
  @route 'home', path: ''

WaxPoetic.Router.reopen location: 'history'

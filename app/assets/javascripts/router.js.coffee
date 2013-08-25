# For more information see: http://emberjs.com/guides/routing/

WaxPoetic.Router.map () ->
  @resource 'releases', { path: '/releases' }, ->
    @route 'show', path: ':id'
  @resource 'artists', { path: '/artists' }, ->
    @route 'show', path: ':id'
  @route 'about', path: '/about'
  @route 'contact', path: '/contact'
  @route 'shop', path: '/shop'

WaxPoetic.Router.reopen location: 'history'

# For more information see: http://emberjs.com/guides/routing/

WaxPoetic.Router.map () ->
  @resource 'releases', { path: '/releases' }, ->
    @route 'show', path: ':id'
  @resource 'artists', { path: '/artists' }, ->
    @route 'show', path: ':id'
  @route 'about', path: '/about'
  @route 'contact', path: '/contact'
  @resource 'shop', { path: '/shop' }, ->
    @resource 'products', { path: 'products' }, ->
      @route 'show', path: ':id'
    @resource 'orders', { path: 'orders' }, ->
      @route 'index', path: ''
      @route 'show', path: ':id'
    @route 'cart', path: 'cart'
    @route 'index', path: ''

WaxPoetic.Router.reopen location: 'history'

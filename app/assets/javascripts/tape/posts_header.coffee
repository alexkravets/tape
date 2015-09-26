class @PostsHeader
  constructor: (@list) ->
    @_add_subscriptions()
    @_add_refresh()


  # PRIVATE ===============================================

  _add_subscriptions: ->
    @list.$subscriptions =$ "<a href='#/tape/subscriptions' class='tape-header-subscriptions'>Subscriptions</a>"
    @list.$search.before(@list.$subscriptions)


  _add_refresh: ->
    @list.$refresh =$ "<a href='#' class='tape-refresh-posts'>Refresh</a>"
    @list.$refresh.on 'click', (e) =>
      e.preventDefault()
      @_refesh()

    @list.$header.prepend(@list.$refresh)


  _refesh: ->
    @list.showSpinner()
    $.get '/admin/tape_posts/new', =>
      @list.updateItems()


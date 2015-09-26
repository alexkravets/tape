class @TapePostsItem extends Item
  constructor: (@module, @path, @object, @config) ->
    @$el =$ """<a class='item tape-item' href='#{ @object.url }' data-id='#{ @object._id }' target='_blank'></a>"""
    @render()


  # PRIVATE ===============================================

  _render_meta: (subscription_title, published_at) ->
    if ! @$meta
      @$meta_subscription_title =$ "<span class='tape-post-subscription-title'>"
      @$meta_published_at       =$ "<span class='tape-post-published-at'>"
      @$meta                    =$ "<div class='tape-post-meta'>"
      @$meta
        .append(@$meta_subscription_title)
        .append(@$meta_published_at)
      @$el.append(@$meta)

    @$meta_subscription_title.html(subscription_title)
    @$meta_published_at.html(published_at)


  _render_title: (title) ->
    if ! @$title
      @$title =$ "<div class='tape-post-title'>"
      @$el.append(@$title)

    @$title.html(title)


  _render_summary: (summary) ->
    if ! @$summary
      @$summary =$ "<div class='tape-post-summary'>"
      @$el.append(@$summary)

    @$summary.html(summary)


  # PUBLIC ================================================

  render: ->
    title              = @object['_list_item_title'].plainText()
    subscription_title = @object['subscription_title'].plainText()
    published_at       = @object['_list_item_subtitle'].plainText()
    summary            = @object['summary'].plainText()

    @_render_meta(subscription_title, published_at)
    @_render_title(title)
    @_render_summary(summary)

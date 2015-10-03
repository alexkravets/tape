class @TapePostsItem extends Item
  constructor: (@module, @path, @object, @config) ->
    @$el =$ """<a class='item tape-post' href='#{ @object.url }' data-id='#{ @object._id }' target='_blank'></a>"""
    @render()


  # PRIVATE ===============================================

  _render_meta: (subscription_title, subscription_icon_url, published_at) ->
    if ! @$meta
      @$meta_subscription_title =$ "<span class='tape-post-subscription-title'>"
      @$meta_subscription_icon  =$ "<img class='tape-post-subscription-icon' src='' />"
      @$meta_published_at       =$ "<span class='tape-post-published-at'>"
      @$meta                    =$ "<div class='tape-post-meta'>"
      @$meta
        .append(@$meta_subscription_icon)
        .append(@$meta_subscription_title)
        .append(@$meta_published_at)
      @$el.append(@$meta)

    @$meta_subscription_icon.attr 'src', subscription_icon_url
    @$meta_subscription_title.html(subscription_title)
    @$meta_published_at.html(published_at)


  _render_image: (image_url) ->
    if ! @$image
      @$image =$ "<img class='tape-post-image'>"
      @$el.append(@$image)

    @$image.attr('src', image_url)


  _render_title: (title) ->
    if ! @$title
      @$title =$ "<div class='tape-post-title'>"
      @$el.append(@$title)

    @$title.html(title)


  _render_summary: (summary) ->
    if summary == ''
      @$summary?.remove()

    else
      if ! @$summary
        @$summary =$ "<div class='tape-post-summary'>"
        @$el.append(@$summary)

      @$summary.html(summary)


  # PUBLIC ================================================

  render: ->
    image_url             = @object['_list_item_thumbnail'].plainText()
    title                 = @object['_list_item_title'].plainText()
    subscription_icon_url = @object['subscription_icon_url'].plainText()
    subscription_title    = @object['subscription_title'].plainText()
    published_at          = @object['_list_item_subtitle'].plainText()
    summary               = @object['summary'].plainText()

    @_render_meta(subscription_title, subscription_icon_url, published_at)

    # if image_url != ''
    #   @_render_image(image_url)

    @_render_title(title)
    @_render_summary(summary)

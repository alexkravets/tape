class @WebsiteView
  constructor: (@view) ->
    @object = @view.object

    @_link_inputs()

    if @object
      @_disable_title()

    else
      @_initialize_form_new()


  # PRIVATE ===============================================

  _disable_title: ->
    @$websiteUrlInput.$input.prop('disabled', true)
    @$websiteUrlInput.$el.addClass('input-disabled')


  _initialize_form_new: ->
    @_add_next()
    @_hide_save()
    @_hide_optional_inputs()


  _link_inputs: ->
    @$websiteUrlInput = @view.form.inputs.website_url
    @$titleInput      = @view.form.inputs.title
    @$channelsInput   = @view.form.inputs.channels


  _add_next: ->
    @$next =$ "<a href='#' class='tape-header-next'>Next</a>"
    @$next.on 'click', (e) =>
      @_fetch_new_subscription()
      e.preventDefault()
    @view.$header.append @$next


  _hide_next: ->
    @$next.hide()


  _hide_save: ->
    @view.$saveBtn.hide()


  _hide_optional_inputs: ->
    @$titleInput.$el.hide()
    @$channelsInput.$el.hide()


  _show_save: ->
    @view.$saveBtn.show()


  _fetch_new_subscription: ->
    website_url = @$websiteUrlInput.$input.val()

    if website_url == ''
      @$websiteUrlInput.showErrorMessage("is required")

    else
      @view.showSpinner()
      $.get '/admin/tape_subscriptions/new', { url: website_url }, (subscription) =>
        @view.hideSpinner()

        if ! subscription
          @$websiteUrlInput.showErrorMessage("can't be reached")

        else if ! subscription.channels
          @$websiteUrlInput.showErrorMessage("doesn't have RSS channels")

        else
          @_update_optional_inputs(subscription)
          @_show_optional_inputs()


  _update_optional_inputs: (subscription) ->
    @$websiteUrlInput.updateValue(subscription.website_url)
    @$titleInput.updateValue(subscription.title)
    @$channelsInput.updateValue(subscription.channels)

    @_ignore_id_for_channel_documents()


  _ignore_id_for_channel_documents: ->
    for f in @$channelsInput.forms
      f.inputs._id.config.ignoreOnSubmission = true


  _show_optional_inputs: ->
    @$websiteUrlInput.$el.hide()
    @$titleInput.$el.show()
    @$channelsInput.$el.show()

    @_show_save()
    @_hide_next()





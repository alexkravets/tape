#= require_tree ./tape

class @Tape
  constructor: (title, apiPath) ->
    config =
      title: title

      itemClass: TapePostsItem

      onListInit: (list) ->
        new PostsHeader(list)

      arrayStore: new RailsArrayStore({
        resource:    'tape_post'
        path:        "#{ apiPath }/tape_posts"
        sortBy:      'published_at'
        sortReverse: true
        searchable:  true
      })

      items:
        subscriptions:
          arrayStore: new RailsArrayStore({
            resource:   'tape_subscription'
            path:       "#{ apiPath }/tape_subscriptions"
            sortBy:     'title'
            searchable: true
          })

          formSchema:
            website_url: { type: 'string', placeholder: 'Website url', label: 'Website', required: true }
            title:       { type: 'string', placeholder: 'Subscription title', required: true }
            channels:
              type: 'documents'
              formSchema:
                title : { type: 'hidden' }
                url   : { type: 'hidden' }
                active:
                  type: 'switch'
                  onInitialize: (input) ->
                    input.$label.html """<span class='tape-channel-title'>#{ input.object.title }</span><br />
                                         <span class='tape-channel-url'>#{ input.object.url }</span>"""

          onViewShow: (view) ->
            new WebsiteView(view)

    return config

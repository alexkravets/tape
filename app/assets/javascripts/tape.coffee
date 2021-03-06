#= require_tree ./tape

class @Tape
  constructor: (title='RSS', apiPath='/admin') ->
    config =
      title: title
      menuIcon: 'feed'

      itemClass: TapePostsItem

      onListInit: (list) ->
        new PostsHeader(list)

      onModuleInit: (module) ->
        if module.chr.isDesktop()
          module.chr.$mainMenu.find('.menu-tape').attr 'href', '#/tape/subscriptions'

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
            website_icon_url: { type: 'hidden' }

            group_panel:
              type: "group"
              groupClass: "group-panel"
              inputs:
                title:
                  type: 'string'
                  placeholder: 'Subscription title'
                  required: true

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

                website_url:
                  type: 'string'
                  placeholder: 'Website url'
                  label: 'Website'
                  required: true

          onViewShow: (view) ->
            new WebsiteView(view)

    return config

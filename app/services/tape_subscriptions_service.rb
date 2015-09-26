class TapeSubscriptionsService

  def fetch
    @subscriptions = TapeSubscription.all
    @subscriptions.each { |s| fetch_subscription_posts(s) }
  end


  private

    def fetch_subscription_posts(subscription)
      ap subscription.title

      subscription.active_channels.each do |channel|
        ap channel.url

        feedjira_feed = Feedjira::Feed.fetch_and_parse channel.url

        create_new_posts(subscription, channel, feedjira_feed)
      end
    end


    def create_new_posts(subscription, channel, feedjira_feed)
      feedjira_feed.entries.each do |e|
        ap " - #{ e.title }"

        title   = textify(e.title)
        summary = normalize(e.summary)

        subscription.posts.create({ entry_id:           e.entry_id,
                                    title:              title,
                                    url:                e.url,
                                    summary:            summary,
                                    published_at:       e.published,
                                    subscription_title: subscription.title,
                                    channel_title:      channel.title,
                                    channel_url:        channel.url })
      end
    end


    def normalize(string)
      text = textify(string)
      ActionController::Base.helpers.truncate(text, length: 160)
    end


    def textify(string)
      if string
        ActionController::Base.helpers.strip_tags(string.presence.sanitize).gsub("\n", ' ').strip
      else
        ''
      end
    end

end

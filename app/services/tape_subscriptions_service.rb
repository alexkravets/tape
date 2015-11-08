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
        begin
          feedjira_feed = Feedjira::Feed.fetch_and_parse channel.url
        rescue # Feedjira::NoParserAvailable
          ap "Bad feed URL: #{ channel.url } — #{ channel.title }"
        else
          create_new_posts(subscription, channel, feedjira_feed)
        end
      end
    end


    def create_new_posts(subscription, channel, feedjira_feed)
      feedjira_feed.entries.each do |e|
        ap " - #{ e.title }"

        title   = textify(e.title)
        summary = normalize(e.summary)

        subscription.posts.create({ entry_id:              e.entry_id,
                                    title:                 title,
                                    url:                   e.url,
                                    summary:               summary,
                                    image_url:             '', #post_image_url(e.url),
                                    published_at:          e.published,
                                    subscription_title:    subscription.title,
                                    subscription_icon_url: subscription.website_icon_url,
                                    channel_title:         channel.title,
                                    channel_url:           channel.url })
      end
    end


    def normalize(string)
      text = textify(string)
      ActionController::Base.helpers.truncate(text, length: 240)
    end


    def textify(string)
      if string.nil?
        ''
      else
        ActionController::Base.helpers.strip_tags(string.sanitize).gsub("\n", ' ').strip
      end
    end

    def post_image_url(post_url)
      image_url = ''

      doc = Nokogiri::HTML(open(post_url))

      (doc/'meta').each do |m|
        next unless m['property']
        if m['property'].downcase.strip == 'og:image'
          image_url = m['content']
          break
        end
      end

      if ! image_url.empty?
        return image_url
      end

      return ''
    end
end

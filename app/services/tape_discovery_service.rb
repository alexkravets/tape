class TapeDiscoveryService

  CONTENT_TYPES = [
    'application/x.atom+xml',
    'application/atom+xml',
    'application/xml',
    'text/xml',
    'application/rss+xml',
    'application/rdf+xml',
  ].freeze

  def initialize(url)
    @url_uri = URI.parse(url)
    url = "#{ @url_uri.scheme or 'http' }://#{ @url_uri.host }#{ @url_uri.path }"
    url << "?#{ @url_uri.query }" if @url_uri.query

    begin
      html = Nokogiri::HTML(open(url))

    rescue RuntimeError
      if url.start_with? 'http://'
        url.gsub!('http://', 'https://')
        html = Nokogiri::HTML(open(url))

      # TODO: add anther option for https://www for naked subdomain
      else
        url  = ''
        html = ''

      end

    rescue SocketError
      ap "Bad server address: #{ url }"
      url  = ''
      html = ''

    rescue Errno::ECONNREFUSED
      ap "Scheme is not supported: #{ url }"
      url  = ''
      html = ''

    end

    @url  = url
    @html = html
  end


  def fetch_subscription
    if @url.empty?
      return nil
    end

    icon_url = fetch_icon()

    ap icon_url

    @subscription = TapeSubscription.new({
      title:            title,
      website_url:      @url,
      website_icon_url: icon_url
    })

    add_feeds()

    return @subscription
  end


  def fetch_icon
    icon_url = ''

    json = Net::HTTP.get(URI("http://icons.better-idea.org/api/icons?url=#{ @url }"))
    data = JSON.parse(json)
    icon = data['icons'].first

    if icon
      icon_url = icon.fetch('url', '')
    end

    return icon_url
  end


  private

    def title
      (@html.css('title').text.presence || 'No Title') .sanitize
    end


    def add_feeds
      @feed_urls = []
      doc = @html

      if doc.at('base') and doc.at('base')['href']
        @base_uri = doc.at('base')['href']
      else
        @base_uri = nil
      end

      (doc/'atom:link').each do |l|
        next unless l['rel']
        if l['type'] and CONTENT_TYPES.include?(l['type'].downcase.strip) and l['rel'].downcase == 'self'
          add_feed(l['title'], l['href'], @url, @base_uri)
        end
      end

      (doc/'link').each do |l|
        next unless l['rel']
        if l['type'] and CONTENT_TYPES.include?(l['type'].downcase.strip) and (l['rel'].downcase =~ /alternate/i or l['rel'] == 'service.feed')
          add_feed(l['title'], l['href'], @url, @base_uri)
        end
      end
    end


    def add_feed(feed_title, feed_url, orig_url, base_uri = nil)
      title = feed_title.presence || 'Channel'
      url   = feed_url.sub(/^feed:/, '').strip

      if base_uri
        url = URI.parse(base_uri).merge(feed_url).to_s
      end

      begin
        uri = URI.parse(url)
      rescue
        puts "Error with `#{url}'"
        exit 1
      end

      unless uri.absolute?
        orig = URI.parse(orig_url)
        url = orig.merge(url).to_s
      end

      if ! @feed_urls.include?(url)
        @feed_urls << url
        @subscription.channels.new(title: title, url: url)
      end
    end

end

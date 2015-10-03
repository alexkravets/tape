class TapePost
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Ants::Id


  ## Attributes
  field :entry_id
  field :title
  field :url
  field :summary
  field :image_url, default: ''
  field :published_at, type: DateTime
  field :subscription_title
  field :subscription_icon_url, default: ''
  field :channel_title
  field :channel_url


  ## Validations
  validates_uniqueness_of :entry_id


  ## Search
  search_in :title, :subscription_title


  ## Scopes
  default_scope -> { desc(:published_at) }


  ## Relations
  belongs_to :subscription, class_name: 'TapeSubscription'


  ## Helpers
  def _list_item_title
    title
  end


  def _list_item_subtitle
    if published_at > DateTime.now - 6.hours
      ActionController::Base.helpers.time_ago_in_words(published_at) + ' ago'

    elsif published_at.today?
      published_at.strftime("%H:%M")

    elsif published_at.year == DateTime.now.year
      published_at.strftime("%d %b at %H:%M")

    else
      published_at.strftime("%d %b %Y at %H:%M")

    end
  end


  def _list_item_thumbnail
    image_url
    # if ! image_url.empty?
    #   width   = 480
    #   height  = 260
    #   quality = 70
    #   return "http://www.you-tracker.com/API/ImageResizer?ytw=#{ width }&yth=#{ height }&ytaspect=true&ytquality=#{ quality }&ytimageurl=#{ image_url }"
    # end
  end

end

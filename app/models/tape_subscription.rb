class TapeSubscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Ants::Id

  ## Attributes
  field :title
  field :website_url
  field :website_icon_url, default: ''

  ## Validators
  validates_presence_of :title
  validates_presence_of :website_url

  ## Search
  search_in :title

  ## Relations
  has_many    :posts,    class_name: 'TapePost', dependent: :destroy
  embeds_many :channels, class_name: 'TapeChannel'
  accepts_nested_attributes_for :channels

  ## Helpers
  def _list_item_title
    title
  end

  # def _list_item_subtitle
  #   website_url
  # end

  # def _list_item_thumbnail
  #   website_icon_url
  # end

  def active_channels
    channels.select { |c| c.active }
  end
end

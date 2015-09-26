class TapeChannel
  include Mongoid::Document
  include Ants::Id


  ## Attributes
  field :title
  field :url
  field :active, type: Boolean, default: true


  ## Validators
  validates_presence_of :title
  validates_presence_of :url


  ## Relations
  embedded_in :subscription, class_name: 'TapeSubscription'

end

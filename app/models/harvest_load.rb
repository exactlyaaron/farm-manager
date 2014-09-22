class HarvestLoad < ActiveRecord::Base
  include PublicActivity::Common
  
  belongs_to :field

  # validates_presence_of :field_id
  validates_presence_of :date
  validates_presence_of :receipt_number
  validates_presence_of :price_per_bushel
  validates_presence_of :bushels_sold
end

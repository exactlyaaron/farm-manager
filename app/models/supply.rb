class Supply < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :kind
  validates_presence_of :name
  validates_presence_of :purchase_date
  validates_presence_of :vendor
  validates_presence_of :measure
  validates_presence_of :price

end

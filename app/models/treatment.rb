class Treatment < ActiveRecord::Base
  belongs_to :field
  belongs_to :supply

  validates_presence_of :field_id
  validates_presence_of :supply_id
  validates_presence_of :quantity
  validates_presence_of :date
end

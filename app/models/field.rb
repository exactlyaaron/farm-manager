class Field < ActiveRecord::Base
  belongs_to :user
  has_many :treatments

  validates_presence_of :name
  validates_presence_of :acreage
  validates_presence_of :crop
end

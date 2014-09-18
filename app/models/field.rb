class Field < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :acreage
  validates_presence_of :crop
end

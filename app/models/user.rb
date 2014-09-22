require 'quandl'
# require 'quandl/client'
# Quandl::Client.use 'http://quandl.com/api/'
# Quandl::Client.token = ENV['QUANDL_KEY']


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:facebook]

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  validates :password, length: {minimum: 8}, on: :create

  has_many :supplies
  has_many :fields

  before_save :default_values
  def default_values
    self.budget ||= 0
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

#   def get_crop_data(crop)
#     if crop == 'corn'
#       crop_data = Quandl::Client::Dataset.find('CHRIS/CME_C1')
#     elsif crop == 'soybeans'
#       crop_data = Quandl::Client::Dataset.find('CHRIS/CME_S1')
#     elsif crop == 'wheat'
#       crop_data = Quandl::Client::Dataset.find('CHRIS/ICE_IW1')
#     end
#     @dataset = crop_data.data.collapse('weekly').trim_start((Date.today - 30).to_s).trim_end(Date.today.to_s)
#     return @dataset
#   end

#   def get_crop_prices(crop)
#     @prices = []
#     dataset = get_crop_data(crop)
#     dataset.each do |array|
#       @prices << array[4]
#     end
#     return @prices
#   end

#   def get_latest_price(crop)
#     prices = get_crop_prices(crop)
#     @latest_price = prices[0]
#   end

#   def get_latest_change(crop)
#     dataset = get_crop_data(crop)
#     @latest_change = dataset.first[5]
#   end
end

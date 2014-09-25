require 'quandl/client'
require 'pry'

Quandl::Client.use 'http://quandl.com/api/'
Quandl::Client.token = ENV['QUANDL_KEY']

class QuandlData
  def initialize(crop_name)
    @crop_name = crop_name
  end

  def data
    @data ||= self.class.get_crop_data(@crop_name)
  end

  def self.get_crop_data(crop)
    if crop == 'Corn'
      crop_data = Rails.cache.fetch("corn_data", :expires_in => 3.hours) do
        puts "||||||||||||||||||||| CALLING API"
        Quandl::Client::Dataset.find('CHRIS/CME_C1')
      end
      # crop_data = Quandl::Client::Dataset.find('CHRIS/CME_C1')
    elsif crop == 'Soybeans'
      crop_data = Rails.cache.fetch("soybean_data", :expires_in => 3.hours) do
        puts "||||||||||||||||||||| CALLING API"
        Quandl::Client::Dataset.find('CHRIS/CME_S1')
      end
      # crop_data = Quandl::Client::Dataset.find('CHRIS/CME_S1')
    elsif crop == 'Wheat'
      crop_data = Rails.cache.fetch("wheat_data", :expires_in => 3.hours) do
        puts "||||||||||||||||||||| CALLING API"
        Quandl::Client::Dataset.find('CHRIS/ICE_IW1')
      end
      # crop_data = Quandl::Client::Dataset.find('CHRIS/ICE_IW1')
    end

    if crop_data
      @dataset = crop_data.data.collapse('daily').trim_start(1.month.ago.to_s).trim_end(Date.today.to_s)
    end
    return @dataset
  end

  def get_crop_prices
    @prices = []
    if data
      data.each do |array|
        @prices << array[4]
      end
    end
    return @prices
  end

  def get_latest_price
    @latest_price = 0
    prices = get_crop_prices
    if prices
      @latest_price = prices[0]
    else
      @latest_price = 9999
    end
    return @latest_price
  end

  def get_latest_change
    @latest_change = 0
    prices = get_crop_prices
    if prices
      @latest_change = prices[0] - prices[1]
    else
      @latest_change = 0
    end
    return @latest_change
  end
end
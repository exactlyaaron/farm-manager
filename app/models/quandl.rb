require 'quandl/client'

Quandl::Client.use 'http://quandl.com/api/'
Quandl::Client.token = ENV['QUANDL_KEY']

class QuandlData < ActiveRecord::Base
  def self.get_crop_data(crop)
    if crop == 'Corn'
      crop_data = Quandl::Client::Dataset.find('CHRIS/CME_C1')
    elsif crop == 'Soybeans'
      crop_data = Quandl::Client::Dataset.find('CHRIS/CME_S1')
    elsif crop == 'Wheat'
      crop_data = Quandl::Client::Dataset.find('CHRIS/ICE_IW1')
    end
    if crop_data
      @dataset = crop_data.data.collapse('weekly').trim_start((Date.today - 90).to_s).trim_end(Date.today.to_s)
    end
    return @dataset
  end

  def self.get_crop_prices(crop)
    @prices = []
    dataset = get_crop_data(crop)
    if dataset
      dataset.each do |array|
        @prices << array[4]
      end
    end
    return @prices
  end

  def self.get_latest_price(crop)
    prices = get_crop_prices(crop)
    @latest_price = prices[0]
  end

  def self.get_latest_change(crop)
    dataset = get_crop_data(crop)
    @latest_change = dataset.first[5]
  end
end
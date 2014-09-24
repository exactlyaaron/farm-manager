class CropPricesController < ApplicationController
  def index
    @corn_prices = QuandlData.get_crop_prices("Corn")
    @latest_corn_price = QuandlData.get_latest_price("Corn")
    @corn_change = QuandlData.get_latest_change("Corn")

    @soybean_prices = QuandlData.get_crop_prices("Soybeans")
    @latest_soybean_price = QuandlData.get_latest_price("Soybeans")
    @soybean_change = QuandlData.get_latest_change("Soybeans")

    @wheat_prices = QuandlData.get_crop_prices("Wheat")
    @latest_wheat_price = QuandlData.get_latest_price("Wheat")
    @wheat_change = QuandlData.get_latest_change("Wheat")

  end
end
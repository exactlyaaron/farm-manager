require 'pry'

class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    get_finance_numbers
    get_prices
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id).limit(8)
  end

  def finances
    get_finance_numbers
    @budget = current_user.budget
  end

  def get_prices
    @corn_data = QuandlData.new("Corn")
    @corn_prices = @corn_data.get_crop_prices
    gon.corn_prices = @corn_prices
    @latest_corn_price = @corn_data.get_latest_price
    @corn_change = @corn_data.get_latest_change

    @soybean_data = QuandlData.new("Soybeans")
    @soybean_prices = @soybean_data.get_crop_prices
    gon.soybean_prices = @soybean_prices
    @latest_soybean_price = @soybean_data.get_latest_price
    @soybean_change = @soybean_data.get_latest_change

    @wheat_data = QuandlData.new("Wheat")
    @wheat_prices = @wheat_data.get_crop_prices
    gon.wheat_prices = @wheat_prices
    @latest_wheat_price = @wheat_data.get_latest_price
    @wheat_change = @wheat_data.get_latest_change
  end

  def get_finance_numbers
    @fields = current_user.fields.includes({:treatments => :supply}, :harvest_loads).all
    @supplies = current_user.supplies;

    @total_expenses = 0    
    @supplies.each do |supply|
      @total_expenses += supply.price
    end

    @total_income = 0
    @fields.each do |field|
      @total_income += field.income
    end

    @projected_revenue = 0
    @fields.each do |field|
      @projected_revenue += field.estimate_revenue
    end
  end

end
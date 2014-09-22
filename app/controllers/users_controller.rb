class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    get_finance_numbers
    get_prices
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id)
  end

  def get_prices
    # @corn_prices = current_user.get_crop_prices("corn")
    # @latest_corn_price = current_user.get_latest_price("corn")
    # @corn_change = current_user.get_latest_change("corn")

    # @soybean_prices = current_user.get_crop_prices("soybeans")
    # @latest_soybean_price = current_user.get_latest_price("soybeans")
    # @soybean_change = current_user.get_latest_change("soybeans")

    # @wheat_prices = current_user.get_crop_prices("wheat")
    # @latest_wheat_price = current_user.get_latest_price("wheat")
    # @wheat_change = current_user.get_latest_change("wheat")
  end

  def get_finance_numbers
    @total_expenses = 0
    current_user.fields.each do |field|
      @total_expenses += field.cost
    end

    @total_income = 0
    current_user.fields.each do |field|
      @total_income += field.income
    end

    @projected_revenue = 0
    current_user.fields.each do |field|
      @projected_revenue += field.estimate_revenue
    end
  end

end
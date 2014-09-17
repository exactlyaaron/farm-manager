class SuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_supplies

  def find_user_supplies
    @supplies = current_user.supplies.all
  end

  def index
    @total = @supplies.sum(:price)

    @chemical_total = @supplies.where(kind: "chemical").sum(:price)
    @fertilizer_total = @supplies.where(kind: "fertilizer").sum(:price)
    @seed_total = @supplies.where(kind: "seed").sum(:price)
    @other_total = @supplies.where(kind: "other").sum(:price)

  end

  def create
    @supply = current_user.supplies.create(supply_params)
    @supplies = current_user.supplies.all
    if @supply.save
      flash[:notice] = "#{@supply.name} purchase has been added to your supplies."
      redirect_to "/supplies/#{@supply.kind}"
    else
      flash[:alert] = "Purchase could not be added."
      redirect_to new_supply_path
    end
  end

  def new
    @supply = Supply.new
    @kind = params[:kind]
  end

  def show_kind
    @kind = params[:kind]
    @list = @supplies.where(kind: "#{@kind}")
    @list_total = @list.sum(:price)
    render 'supplies/specific'
  end
  
  protected

  def supply_params
    params.require(:supply).permit(:kind, :name, :purchase_date, :vendor, :measure, :price)
  end
end
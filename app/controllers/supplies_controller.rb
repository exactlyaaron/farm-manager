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
    if @supply.price && @supply.quantity
      @supply.create_activity :create, owner: current_user
      @supply.unit_cost = (@supply.price / @supply.quantity).round(2)
    end
    @supplies = current_user.supplies.all
    if @supply.save
      flash[:notice] = "#{@supply.name} purchase has been added to your supplies."
      redirect_to "/supplies/#{@supply.kind}"
    else
      flash[:alert] = "Purchase could not be added."
      redirect_to new_supply_path
    end
  end

  def destroy
    @kind = params[:kind]
    @id = params[:id]
    Supply.destroy(@id)
    redirect_to :back
  end

  def edit
    @supply = Supply.find(params[:id])
  end

  def new
    @supply = Supply.new
    @kind = params[:kind]
  end

  def update
    @supply = Supply.find(params[:id])
    if @supply.update(supply_params)
      flash[:notice] = "#{@supply.name} has been updated."
      redirect_to "/supplies/#{@supply.kind}"
    else
      flash[:alert] = "Purchase could not be updated."
      render edit_supply_path(@supply)
    end
  end

  def show_kind
    @kind = params[:kind]
    @list = @supplies.where(kind: "#{@kind}")
    @list_total = @list.sum(:price)
    render 'supplies/specific'
  end

  protected

  def supply_params
    params.require(:supply).permit(:kind, :name, :purchase_date, :vendor, :measure, :price, :quantity)
  end
end
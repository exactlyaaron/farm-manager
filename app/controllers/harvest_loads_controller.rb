class HarvestLoadsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_info

  def find_user_info
    @fields = current_user.fields.all
    @field = Field.find(params[:id])
  end

  def create
    @field = Field.find(params[:id])
    @harvest_load = @field.harvest_loads.create(harvest_load_params)
    @fields = current_user.fields.all
    if @harvest_load.save
      @harvest_load.create_activity :create, owner: current_user
      flash[:notice] = "Harvest record has been added to your field."
      redirect_to field_path(@field)
    else
      flash[:alert] = "Harvest record could not be added."
      redirect_to new_field_path
    end
  end

  def destroy
    @id = params[:harvest_load_id]
    HarvestLoad.find(@id).create_activity :destroy, owner: current_user
    HarvestLoad.destroy(@id)
    redirect_to :back
  end

  def edit
    @harvest_load = HarvestLoad.find(params[:harvest_load_id])
  end

  def new
    @harvest_load = HarvestLoad.new
  end

  def update
    @field = Field.find(params[:id])
    @harvest_load = HarvestLoad.find(params[:harvest_load_id])
    if @harvest_load.update(harvest_load_params)
      flash[:notice] = "Harvest record was updated successfully."
      redirect_to field_path(@field)
    else
      flash[:alert] = "Harvest record could not be updated."
      render edit_field_path(@field)
    end
  end

  protected

  def harvest_load_params
    params.require(:harvest_load).permit(:receipt_number, :price_per_bushel, :bushels_sold, :date)
  end
end
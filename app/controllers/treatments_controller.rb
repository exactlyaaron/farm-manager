class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_info

  def find_user_info
    @fields = current_user.fields.all
    @field = Field.find(params[:id])
    @supplies = current_user.supplies.all
  end

  def create
    @field = Field.find(params[:id])
    @treatment = @field.treatments.create(treatment_params)
    # @treatment.date = params[:date].strftime("%m/%d/%Y")
    @fields = current_user.fields.all
    if @treatment.save
      flash[:notice] = "#{@treatment.supply.name} has been added to your field."
      redirect_to field_path
    else
      flash[:alert] = "Treatment could not be added."
      redirect_to new_field_path
    end
  end

  def destroy
    # @id = params[:id]
    # Field.destroy(@id)
    # redirect_to :back
  end

  def edit
    # @field = Field.find(params[:id])
  end

  def new
    @treatment = Treatment.new
  end

  # def index
  #   @total_acreage = @fields.sum(:acreage)
  # end

  # def show
  #   @field = Field.find(params[:id])
  # end

  # def update
  #   @field = Field.find(params[:id])
  #   if @field.update(field_params)
  #     flash[:notice] = "#{@field.name} has been updated."
  #     redirect_to field_path(@field)
  #   else
  #     flash[:alert] = "Field could not be updated."
  #     render edit_field_path(@field)
  #   end
  # end

  protected

  def treatment_params
    params.require(:treatment).permit(:supply_id, :date, :quantity)
  end
end
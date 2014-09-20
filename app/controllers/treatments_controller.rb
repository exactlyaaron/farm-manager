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
      redirect_to field_path(@field)
    else
      flash[:alert] = "Treatment could not be added."
      redirect_to new_field_path
    end
  end

  def destroy
    @id = params[:treatment_id]
    Treatment.destroy(@id)
    redirect_to :back
  end

  def edit
    @treatment = Treatment.find(params[:treatment_id])
  end

  def new
    @treatment = Treatment.new
  end

  # def index
  #   @total_acreage = @fields.sum(:acreage)
  # end

  def show
    @field = Field.find(params[:id])
    @treatment = Treatment.find(params[:treatment_id])
  end

  def update
    @field = Field.find(params[:id])
    @treatment = Treatment.find(params[:treatment_id])
    if @treatment.update(treatment_params)
      flash[:notice] = "Treatment record was updated successfully."
      redirect_to field_path(@field)
    else
      flash[:alert] = "Treatment could not be updated."
      render edit_field_path(@field)
    end
  end

  protected

  def treatment_params
    params.require(:treatment).permit(:supply_id, :date, :quantity)
  end
end
class FieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_fields

  def find_user_fields
    @fields = current_user.fields.all
  end

  def create
    @field = current_user.fields.create(field_params)
    @fields = current_user.fields.all
    if @field.save
      flash[:notice] = "#{@field.name} has been added to your fields."
      redirect_to fields_path
    else
      flash[:alert] = "Field could not be added."
      redirect_to new_field_path
    end
  end

  def destroy
    @id = params[:id]
    Field.destroy(@id)
    redirect_to :back
  end

  def edit
    @field = Field.find(params[:id])
  end

  def new
    @field = Field.new
  end

  def index
    @total_acreage = @fields.sum(:acreage)
  end

  def show
    @field = Field.find(params[:id])
    @treatments = @field.treatments
    @total_field_cost = 0
    @treatments.each do |treatment|
      @total_field_cost += treatment.supply.unit_cost * treatment.quantity
    end
    @total_income = 0
    @field.harvest_loads.each do |load|
      @total_income += load.price_per_bushel * load.bushels_sold
    end
  end

  def update
    @field = Field.find(params[:id])
    if @field.update(field_params)
      flash[:notice] = "#{@field.name} has been updated."
      redirect_to field_path(@field)
    else
      flash[:alert] = "Field could not be updated."
      render edit_field_path(@field)
    end
  end

  protected

  def field_params
    params.require(:field).permit(:name, :acreage, :crop)
  end
end
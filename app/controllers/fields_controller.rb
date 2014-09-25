require 'quandl'

class FieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_fields

  def find_user_fields
    @fields = current_user.fields.all
  end

  def create
    @fields = current_user.fields.all
    @field = current_user.fields.create(field_params)
    crop_data = QuandlData.new(field_params[:crop])
    @latest_price = crop_data.get_latest_price
    if @latest_price
      @field.crop_price = (@latest_price / 100)
    else
      @field.crop_price = 0
    end
    if @field.save
      @field.create_activity :create, owner: current_user
      flash[:notice] = "#{@field.name} has been added to your fields."
      redirect_to fields_path
    else
      flash[:alert] = "Field could not be added."
      redirect_to new_field_path
    end
  end

  def destroy
    @id = params[:id]
    Field.find(@id).create_activity :destroy, owner: current_user
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
    @total_income = 0
    @fields.each do |field|
      @total_income += field.income
    end
    @projected_revenue = 0
    @fields.each do |field|
      @projected_revenue += field.estimate_revenue
    end
  end

  def show
    @field = Field.find(params[:id])
    @treatments = @field.treatments

    @total_field_cost = @field.cost
    @total_income = @field.income
    @projected_revenue = @field.estimate_revenue
  end

  def update
    @field = Field.find(params[:id])
    edit_params = params.require(:field).permit(:name, :acreage, :crop, :notes)
    if @field.update(edit_params)
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
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

  def new
    @field = Field.new
  end

  def index
    @total_acreage = @fields.sum(:acreage)
  end

  protected

  def field_params
    params.require(:field).permit(:name, :acreage, :crop)
  end
end
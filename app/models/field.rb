class Field < ActiveRecord::Base
  include PublicActivity::Common
  # tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :user
  has_many :treatments
  has_many :harvest_loads

  validates_presence_of :name
  validates_presence_of :acreage
  validates_presence_of :crop

  # def self.update_crop_prices
  #   @fields = Field.all

  #   @fields.each do |field|
  #     @new_price = Field.get_crop_price(field.crop)
  #     field.update(crop_price: @new_price)
  #   end
  # end

  def cost
    @total_cost = 0
    if self.treatments.length > 0
      self.treatments.each do |treatment|
        @total_cost += treatment.supply.unit_cost * treatment.quantity
      end
      return @total_cost
    else
      return @total_cost = 0
    end
  end

  def income
    @total_income = 0
    if self.harvest_loads.length > 0
      self.harvest_loads.each do |load|
        @total_income += load.price_per_bushel * load.bushels_sold
      end
      return @total_income
    else
      return @total_income = 0
    end
  end

  def estimate_revenue
    @estimate = self.crop_price * self.acreage * 175
  end
end

class UpdateSupplyAttributes < ActiveRecord::Migration
  def change
    change_column :supplies, :price,  :decimal
    change_column :supplies, :unit_cost,  :decimal
    change_column :fields, :crop_price,  :decimal
  end
end

class AddUnitCostToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :unit_cost, :integer
  end
end

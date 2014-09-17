class AddQuantityToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :quantity, :integer
  end
end

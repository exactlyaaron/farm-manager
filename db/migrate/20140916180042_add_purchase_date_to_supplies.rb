class AddPurchaseDateToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :purchase_date, :date
  end
end

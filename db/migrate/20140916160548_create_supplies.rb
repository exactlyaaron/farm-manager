class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :kind
      t.string :name
      t.string :vendor
      t.string :measure
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end

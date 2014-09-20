class CreateHarvestLoads < ActiveRecord::Migration
  def change
    create_table :harvest_loads do |t|
      t.integer :field_id
      t.string :receipt_number
      t.decimal :price_per_bushel
      t.decimal :bushels_sold
      t.datetime :date

      t.timestamps
    end
  end
end

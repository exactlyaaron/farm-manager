class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :supply_id
      t.integer :quantity
      t.integer :field_id
      t.string :notes
      t.datetime :date

      t.timestamps
    end
  end
end

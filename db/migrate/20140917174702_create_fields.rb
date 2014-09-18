class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.integer :acreage
      t.string :crop
      t.integer :crop_price
      t.string :notes
      t.integer :user_id

      t.timestamps
    end
  end
end

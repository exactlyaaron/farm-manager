class DropTableAuthentifications < ActiveRecord::Migration
  def change
    drop_table :authentifications
  end
end

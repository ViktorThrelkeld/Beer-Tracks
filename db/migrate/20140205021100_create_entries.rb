class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.integer :ounces
      t.decimal :cost
      t.integer :style_id
    end
  end
end
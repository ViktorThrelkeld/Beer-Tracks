class CreateStyle < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.decimal :abv
      t.decimal :calories_per_ounce
    end
  end
end
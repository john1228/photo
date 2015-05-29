class CreatePhotographers < ActiveRecord::Migration
  def change
    create_table :photographers do |t|
      t.string :name
      t.string :avatar
      t.integer :level
      t.decimal :price
      t.string :city

      t.timestamps
    end
  end
end

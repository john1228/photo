class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.references :photographer
      t.string :title
      t.string :works_type
      t.integer :during

      t.decimal :price
      t.decimal :discount
      t.text :intro
      t.timestamps
    end
  end
end

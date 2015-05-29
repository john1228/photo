class CreateChildStars < ActiveRecord::Migration
  def change
    create_table :child_stars do |t|
      t.string :name
      t.string :nickname
      t.string :country
      t.integer :gender
      t.string :nation
      t.integer :height
      t.integer :weight
      t.date :birthday
      t.string :city
      t.integer :price
    end
  end
end

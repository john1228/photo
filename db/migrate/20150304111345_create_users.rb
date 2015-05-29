class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mobile
      t.string :sns
      t.string :password
      t.string :salt

      t.string :name
      t.string :avatar
      t.integer :gender
      t.date :birthday

      t.string :baby_name
      t.integer :baby_gender
      t.date :baby_birthday

      t.timestamps
    end
  end
end

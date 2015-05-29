class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :photographer
      t.references :user
      t.integer :level #等级（好中差评）
      t.integer :pro #专业
      t.integer :att #态度
      t.integer :pun #守时
      t.text :content

      t.timestamps
    end
  end
end

class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :name
      t.string :phone
      t.string :city
      t.integer :exp
      t.integer :salary
      t.integer :opened
      t.integer :target
      t.timestamps
    end
  end
end

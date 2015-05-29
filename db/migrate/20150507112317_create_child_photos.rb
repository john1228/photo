class CreateChildPhotos < ActiveRecord::Migration
  def change
    create_table :child_photos do |t|
      t.references :child_star
      t.string :photo
    end
  end
end

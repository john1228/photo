class CreateWorksPhotos < ActiveRecord::Migration
  def change
    create_table :works_photos do |t|
      t.references :works
      t.string :photo
      t.string :photo_height
    end
  end
end

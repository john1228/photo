class CreateAppointInfos < ActiveRecord::Migration
  def change
    create_table :appoint_infos do |t|
      t.references :user
      t.string :name
      t.string :phone
      t.string :baby_name
      t.string :baby_gender
      t.string :baby_birthday
      t.timestamps
    end
  end
end

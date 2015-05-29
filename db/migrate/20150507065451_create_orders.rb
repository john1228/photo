class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :photographer
      t.references :works

      t.date :appoint_date
      t.integer :appoint_time
      t.string :appoint_address

      t.string :contact
      t.string :phone
      t.string :baby_name
      t.string :baby_gender
      t.string :baby_birthday


      t.string :order_no
      t.string :coupons
      t.string :price
      t.string :pay_type
      t.integer :status
      t.timestamps
    end
  end
end

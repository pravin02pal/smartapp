class CreateRentTable < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :paid_amount
      t.integer :pending_amount
      t.datetime :paid_date
      t.timestamps
    end
  end
end

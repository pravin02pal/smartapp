class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :rnumber
      t.string :rtype
      t.integer :rent

      t.timestamps
    end
  end
end

class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :identity_number, :string
    add_column :users, :pan_number, :string
    add_column :users, :aadhar_number, :string
    add_column :users, :status, :string
    add_column :users, :gender, :string
  end
end

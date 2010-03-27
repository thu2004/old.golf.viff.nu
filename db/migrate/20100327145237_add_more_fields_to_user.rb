class AddMoreFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :location, :string
    add_column :users, :paid, :boolean, :default => false
    add_column :users, :comment, :text
    add_column :users, :member_since, :string
    add_column :users, :golf_id, :string
    add_column :users, :golf_hcp, :string
    add_column :users, :golf_club, :string
    add_column :users, :type, :string
    add_column :users, :company, :string
  end

  def self.down
    remove_column :users, :company
    remove_column :users, :type
    remove_column :users, :golf_person_nr
    remove_column :users, :golf_club
    remove_column :users, :golf_hcp
    remove_column :users, :golf_id
    remove_column :users, :member_since
    remove_column :users, :comment
    remove_column :users, :paid
    remove_column :users, :location
    remove_column :users, :mobile_phone
    remove_column :users, :phone
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end

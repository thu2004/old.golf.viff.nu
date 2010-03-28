class CreatePlayRights < ActiveRecord::Migration
  def self.up
    create_table :play_rights do |t|
      t.string :name
      t.text :description
      t.integer :num_of_resource
      t.boolean :weekend_allow

      t.timestamps
    end
  end

  def self.down
    drop_table :play_rights
  end
end

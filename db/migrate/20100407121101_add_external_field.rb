class AddExternalField < ActiveRecord::Migration
  def self.up
    add_column :users, :external, :boolean
  end

  def self.down
    remove_column :users, :external
  end
end

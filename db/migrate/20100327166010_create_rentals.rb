class CreateRentals < ActiveRecord::Migration
  def self.up
    create_table :rentals do |t|
      t.column :magazine_item_id, :integer
      t.column :user_id, :integer
      t.column :rent_on, :date
    end
  end

  def self.down
    drop_table :rentals
  end
end

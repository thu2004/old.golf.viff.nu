class CreatePlayRightBookings < ActiveRecord::Migration
  def self.up
    create_table :play_right_bookings do |t|
      t.integer :play_right_id
      t.integer :user_id
      t.integer :num_of_resource
      t.date :when
      t.text :information

      t.timestamps
    end
  end

  def self.down
    drop_table :play_right_bookings
  end
end

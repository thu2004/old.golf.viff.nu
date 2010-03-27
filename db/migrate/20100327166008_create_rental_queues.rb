class CreateRentalQueues < ActiveRecord::Migration
  def self.up
    create_table :rental_queues do |t|
      t.column :magazine_number_id, :integer, :on_delete => :cascade, :on_update => :cascade
      t.column :user_id, :integer, :on_delete => :cascade, :on_update => :cascade
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :rental_queues
  end
end

class CreateRentalSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :rental_subscriptions do |t|
      t.column :magazine_subscription_id, :integer, :on_delete => :cascade, :on_update => :cascade
      t.column :user_id, :integer, :on_delete => :cascade, :on_update => :cascade
    end
  end

  def self.down
    drop_table :rental_subscriptions
  end
end

class CreateRentalHistories < ActiveRecord::Migration
	def self.up
 		create_table :rental_histories do |t|
      t.column :magazine_item_id, :integer
      t.column :user_id, :integer
      t.column :rent_on, :date
      t.column :return_on, :date
    end
  end
    
  def self.down
    drop_table :rental_histories
  end
end

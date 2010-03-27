class AddRentalRemindDate < ActiveRecord::Migration
  def self.up
    add_column :rentals, :last_remind_date, :date
  
    Rental.find(:all).each do |r|
      r.last_remind_date = r.rent_on
      r.save
    end
  end
      
  def self.down
    remove_column :rentals, :last_remind_date
  end
end

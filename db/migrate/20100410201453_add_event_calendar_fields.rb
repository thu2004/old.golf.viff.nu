class AddEventCalendarFields < ActiveRecord::Migration
  def self.up
    rename_column :events, :start_date, :start_at
    rename_column :events, :end_date, :end_at
    add_column :events, :all_day, :boolean
    
    add_column :play_right_bookings, :start_at, :datetime
    add_column :play_right_bookings, :end_at, :datetime
    add_column :play_right_bookings, :all_day, :boolean
    
    PlayRightBooking.find(:all).each do | booking | 
       booking.all_day = true; 
       booking.start_at = booking.end_at = booking.booked_on
       booking.save! 
    end
  end

  def self.down
    remove_column :play_right_bookings, :all_day
    remove_column :play_right_bookings, :end_at
    remove_column :play_right_bookings, :start_at
    remove_column :events, :all_day
    rename_column :events, :end_at, :end_date
    rename_column :events, :start_at, :start_date
  end
end

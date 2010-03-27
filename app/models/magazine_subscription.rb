# == Schema Information
# Schema version: 15
#
# Table name: magazine_subscriptions
#
#  id          :integer(11)     not null, primary key
#  name        :string(255)     
#  description :text            
#

class MagazineSubscription < ActiveRecord::Base
	has_many :magazine_numbers
	has_many :rental_subscriptions
	validates_presence_of :name
	validates_uniqueness_of :name
end

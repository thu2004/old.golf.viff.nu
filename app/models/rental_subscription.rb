# == Schema Information
# Schema version: 15
#
# Table name: rental_subscriptions
#
#  id                       :integer(11)     not null, primary key
#  magazine_subscription_id :integer(11)     
#  user_id                  :integer(11)     
#


class RentalSubscription < ActiveRecord::Base
	belongs_to :magazine_subscription
	belongs_to :user
	
	validates_presence_of :magazine_subscription, :user
	validates_uniqueness_of :magazine_subscription_id, :scope => :user_id
end

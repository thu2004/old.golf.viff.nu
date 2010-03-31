# == Schema Information
# Schema version: 15
#
# Table name: magazine_numbers
#
#  id                       :integer(11)     not null, primary key
#  name                     :string(255)     
#  num_of_copy              :integer(11)     
#  magazine_subscription_id :integer(11)     
#  created_at               :datetime        
#  updated_at               :datetime        
#

class MagazineNumber < ActiveRecord::Base
	belongs_to :magazine_subscription
	has_many :rental_queues, :dependent => :destroy
	has_many :magazine_items, :dependent => :destroy
	validates_presence_of :name
	validates_presence_of :magazine_subscription
	
	def initialize(attributes=nil)
	  @num_of_copy = 0
	  if !attributes.nil? && !attributes[:num_of_copy].nil?
  		@num_of_copy = attributes[:num_of_copy].to_i
	  end
	  super(attributes)
 end
  
  # full name = magazine_subscription_name + magazine_item_name
  def full_name
    "#{magazine_subscription.name} #{name}"
  end

	# return first item which is free to rent, otherwise return nil
	def magazine_item_to_rent
		items_not_out = magazine_items.reject { |i| i.is_rent }
		if items_not_out.size > 0
			return items_not_out[0] 
		else
		  return nil
		end
	end
	
	# return true if there is an item on rent
	def magazine_item_on_rent?
	  magazine_items.each do |i|
	    return true if i.is_rent
	  end
	  return false  
	end
	
	def num_of_copy=(new_value)
	  @num_of_copy = new_value.to_i
	end
	
	def num_of_copy
	  if self.new_record?  
	    return @num_of_copy 
	  else
	    return magazine_items.size
	  end
	end
	
protected
	def validate
		errors.add(:num_of_copy, "should be at least 1" ) if @num_of_copy.nil? || @num_of_copy < 1
		
		return if !self.new_record? # already save. skip futher validation
		
		return if errors.size > 0 # make sure all fields are ok first
		
		# check duplicate magazine number
		
		if (MagazineNumber.find(:first, :conditions => "name = '#{self.name}' and magazine_subscription_id = #{self.magazine_subscription.id}") != nil)
			errors.add(:name, " and subscription already exist in the db")
		end
	end

	def after_create
		# create MagazineItem
		for i in 1..@num_of_copy
			item = MagazineItem.new
			item.magazine_number = self
			item.copy_number = i
			put item.errors if !item.save
		end
	end
	
	def after_update()
	  num_of_copy_in_db = magazine_items.size
	  # add more copy
	  if (num_of_copy_in_db < @num_of_copy)
	    for i in num_of_copy_in_db..@num_of_copy-1
	      item = MagazineItem.new
  			item.magazine_number = self
  			item.copy_number = i
  			put item.errors if !item.save
  		end
  	else # remove some
  	  for i in @num_of_copy+1..num_of_copy_in_db
	      item = magazine_items.find_by_copy_number(i)
  			item.destroy if !item.nil?
  		end
	  end			
	end
end

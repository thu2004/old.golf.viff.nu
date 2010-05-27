class Option < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :value
	
	def self.get(name)
		op = Option.get_i(name)
		if (op == nil)
			return "'#{name} is missing'"
		end
		return op.value
	end
	
	def self.care_not_paid()
	  op = Option.get_i("care_not_paid")
		return (op != nil)
	end
	
	def self.magazine_rental?()
	  op = Option.get_i("magazine_rental")
		return (op != nil)
	end
	
	def self.benefit?()
	  op = Option.get_i("benefit")
		return (op != nil)
	end
	
	def self.golf_section?()
	  op = Option.get("section")
		return (op == "Golfsektionen")
	end

protected
  def self.get_i(option_name)
    op = Option.find(:first, :conditions => ['name = lower(?)', option_name.downcase])
  end	

end

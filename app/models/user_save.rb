require 'digest/sha1'

class User < ActiveRecord::Base
  #-------------------------------------------------------------------------------------------------
   # Added by Thu 

 	has_many :role_positions
 	has_many :roles, :through => :role_positions

   def name
   	"#{first_name} #{last_name}"
   end

   # role
   def has_role?(rolename)
     self.roles.find_by_name(rolename) ? true : false  
   end

   # magazine_admin?

   def magazine_admin?
     has_role?('magazine_admin')
   end

   #admin
   def admin?
     has_role?('system_admin')
   end
end
class CreateRolePositions < ActiveRecord::Migration
  def self.up
     create_table :role_positions, :id => false do |t|
       t.column :user_id, :integer, :null => false, :on_delete => :cascade, :on_update => :cascade
       t.column :role_id, :integer, :null => false, :on_delete => :cascade, :on_update => :cascade
     end
   end

   def self.down
     drop_table :role_positions
   end
end

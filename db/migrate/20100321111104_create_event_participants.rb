class CreateEventParticipants < ActiveRecord::Migration
  def self.up
    create_table :event_participants do |t|
	  t.column :user_id,    :integer, :null => false, :on_delete => :cascade, :on_update => :cascade
	  t.column :event_id,   :integer, :null => false, :on_delete => :cascade, :on_update => :cascade
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :event_participants
  end
end

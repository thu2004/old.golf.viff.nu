class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :name,            :string, :limit => 60
      t.column :description,     :text
      t.column :info_link,       :string, :limit => 80      
      t.column :start_date,      :datetime
      t.column :end_date,        :datetime
      t.column :max_participant, :integer
      t.column :created_at,      :datetime
    end
  end

  def self.down
    drop_table :events
  end
end

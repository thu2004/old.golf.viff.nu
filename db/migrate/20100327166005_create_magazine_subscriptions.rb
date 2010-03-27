class CreateMagazineSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :magazine_subscriptions do |t|      
      t.column :name, :string
      t.column :description, :text 
    end
  end

  def self.down
    drop_table :magazine_subscriptions
  end
end

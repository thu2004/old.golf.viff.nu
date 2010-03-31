class CreateMagazineItems < ActiveRecord::Migration
  def self.up
    create_table :magazine_items do |t|
      t.column :magazine_number_id, :integer
      t.column :copy_number, :integer
    end
  end

  def self.down
    drop_table :magazine_items
  end
end

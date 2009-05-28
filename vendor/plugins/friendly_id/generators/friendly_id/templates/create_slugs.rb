class CreateSlugs < ActiveRecord::Migration
  def self.up
    create_table :slugs do |t|
      t.string :name
      t.integer :sluggable_id
      t.integer :sequence, :null => false, :default => 1
      t.string :sluggable_type, :limit => 40
      t.datetime :created_at
    end
    add_index :slugs, [:name, :sluggable_type, :sequence]
    add_index :slugs, :sluggable_id
  end

  def self.down
    drop_table :slugs
  end
end

class CreateMagazineNumbers < ActiveRecord::Migration
  def self.up
    create_table :magazine_numbers do |t|
			t.column :name, :string
			t.column :num_of_copy, :integer
		  t.column :magazine_subscription_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :magazine_numbers
  end
end

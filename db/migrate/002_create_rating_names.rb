class CreateRatingNames < ActiveRecord::Migration
  def self.up
    create_table :rating_names do |t|
      t.column :name,   :string,  :null => false
      t.column :value,  :integer, :null => false
      t.column :type,   :string,  :null => false
    end
    add_index :rating_names, [:name, :type], :unique => true
  end
  
  def self.down
    drop_table :rating_names
  end
end
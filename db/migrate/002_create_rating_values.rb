class CreateRatingValues < ActiveRecord::Migration
  def self.up
    create_table :rating_names do |t|
      t.column :name, :string,  :null => false
      t.column :rank, :integer, :null => false
      t.column :type, :string,  :null => false
    end
    add_index :rating_names, :name, :unique => true
  end
  
  def self.down
    drop_table_if_exists :rating_names
  end
end
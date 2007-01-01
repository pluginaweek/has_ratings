class CreateRatingValues < ActiveRecord::Migration
  def self.up
    create_table :rating_values do |t|
      t.column :name,   :string,  :null => false
      t.column :value,  :integer, :null => false
      t.column :type,   :string,  :null => false
    end
    add_index :rating_values, [:name, :type], :unique => true, :name => 'unique_rating_names'
  end
  
  def self.down
    drop_table :rating_values
  end
end
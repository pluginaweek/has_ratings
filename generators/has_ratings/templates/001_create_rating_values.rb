class CreateRatingValues < ActiveRecord::Migration
  def self.up
    create_table :rating_values do |t|
      t.string :name, :null => false
      t.integer :value, :null => false
    end
  end
  
  def self.down
    drop_table :rating_values
  end
end

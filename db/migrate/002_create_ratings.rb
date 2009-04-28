class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.references :ratable, :rater, :polymorphic => true, :null => false
      t.references :value, :null => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :ratings
  end
end

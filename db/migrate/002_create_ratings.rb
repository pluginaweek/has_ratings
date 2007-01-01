class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.column :ratable_id, :integer,   :null => false, :unsigned => true, :references => nil
      t.column :rater_id,   :integer,   :null => false, :unsigned => true, :references => nil
      t.column :rater_type, :string,    :null => false
      t.column :value_id,   :integer,   :null => false, :unsigned => true, :references => :rating_values
      t.column :created_at, :datetime,  :null => false
      t.column :type,       :string,    :null => false
    end
    add_index :ratings, [:ratable_id, :rater_id, :type, :rater_type], :unique => true, :name => 'unique_ratings'
  end
  
  def self.down
    drop_table :ratings
  end
end
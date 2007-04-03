class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.column :ratable_id,   :integer,   :null => false, :unsigned => true, :references => nil
      t.column :ratable_type, :string,    :null => false
      t.column :rater_id,     :integer,   :null => false, :unsigned => true, :references => nil
      t.column :rater_type,   :string,    :null => false
      t.column :value,        :integer,   :null => false
      t.column :created_at,   :datetime,  :null => false
    end
    add_index :ratings, [:ratable_id, :ratable_type, :rater_id, :rater_type], :unique => true, :name => 'index_ratings_on_ratable_and_rater'
  end
  
  def self.down
    drop_table :ratings
  end
end
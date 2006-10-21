class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.column :ratable_id,   :integer,   :null => false, :unsigned => true, :references => nil
      t.column :rater_id,     :integer,   :null => false, :unsigned => true, :references => :users
      t.column :value,        :integer,   :null => false
      t.column :created_at,   :datetime,  :null => false
      t.column :type,         :string,    :null => false
    end
    add_index :ratings, [:ratable_id, :rater_id], :unique => true
  end
  
  def self.down
    drop_table_if_exists :ratings
  end
end
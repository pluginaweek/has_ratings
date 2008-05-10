class MigrateHasRatingsToVersion1 < ActiveRecord::Migration
  def self.up
    Rails::Plugin.find(:has_ratings).migrate(1)
  end
  
  def self.down
    Rails::Plugin.find(:has_ratings).migrate(0)
  end
end

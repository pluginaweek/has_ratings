class HasRatingsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template '001_create_rating_values.rb', 'db/migrate', :migration_file_name => 'create_rating_values'
      m.sleep 1
      m.migration_template '002_create_ratings.rb', 'db/migrate', :migration_file_name => 'create_ratings'
    end
  end
end

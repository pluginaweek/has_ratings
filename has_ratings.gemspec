# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_ratings}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2009-06-08}
  s.description = %q{Demonstrates a reference implementation for handling ratings in ActiveRecord}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["app/models", "app/models/rating.rb", "app/models/rating_value.rb", "assets/images", "assets/images/star.gif", "assets/stylesheets", "assets/stylesheets/star.css", "db/migrate", "db/migrate/002_create_ratings.rb", "db/migrate/001_create_rating_values.rb", "lib/has_ratings.rb", "test/unit", "test/unit/rating_test.rb", "test/unit/rating_value_test.rb", "test/factory.rb", "test/app_root", "test/app_root/app", "test/app_root/app/models", "test/app_root/app/models/video.rb", "test/app_root/app/models/user.rb", "test/app_root/db", "test/app_root/db/migrate", "test/app_root/db/migrate/003_migrate_has_ratings_to_version_2.rb", "test/app_root/db/migrate/001_create_users.rb", "test/app_root/db/migrate/002_create_videos.rb", "test/app_root/config", "test/app_root/config/environment.rb", "test/test_helper.rb", "test/functional", "test/functional/has_ratings_test.rb", "CHANGELOG.rdoc", "init.rb", "LICENSE", "Rakefile", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Demonstrates a reference implementation for handling ratings in ActiveRecord}
  s.test_files = ["test/unit/rating_test.rb", "test/unit/rating_value_test.rb", "test/functional/has_ratings_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<enumerate_by>, [">= 0.4.0"])
    else
      s.add_dependency(%q<enumerate_by>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<enumerate_by>, [">= 0.4.0"])
  end
end

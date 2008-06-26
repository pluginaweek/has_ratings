require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the has_ratings plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the has_ratings plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'HasRatings'
  rdoc.template = '../rdoc_template.rb'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s|
  s.name              = 'has_ratings'
  s.version           = '0.0.2'
  s.platform          = Gem::Platform::RUBY
  s.summary           = 'Demonstrates a reference implementation for handling ratings.'
  
  s.files             = FileList['{app,assets,db,lib,test}/**/*'].to_a - FileList['test/app_root/log/*'].to_a + %w(CHANGELOG init.rb LICENSE Rakefile README.rdoc)
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.test_files        = Dir['test/**/*_test.rb']
  s.add_dependency    'acts_as_enumeration', '>= 0.1.0'
  
  s.author            = 'Aaron Pfeifer'
  s.email             = 'aaron@pluginaweek.org'
  s.homepage          = 'http://www.pluginaweek.org'
  s.rubyforge_project = 'pluginaweek'
end
  
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

desc 'Publish the beta gem.'
task :pgem => [:package] do
  Rake::SshFilePublisher.new('aaron@pluginaweek.org', '/home/aaron/gems.pluginaweek.org/public/gems', 'pkg', "#{spec.name}-#{spec.version}.gem").upload
end

desc 'Publish the API documentation.'
task :pdoc => [:rdoc] do
  Rake::SshDirPublisher.new('aaron@pluginaweek.org', "/home/aaron/api.pluginaweek.org/public/#{spec.name}", 'rdoc').upload
end

desc 'Publish the API docs and gem'
task :publish => [:pgem, :pdoc, :release]

desc 'Publish the release files to RubyForge.'
task :release => [:gem, :package] do
  require 'rubyforge'
  
  ruby_forge = RubyForge.new.configure
  ruby_forge.login
  
  %w(gem tgz zip).each do |ext|
    file = "pkg/#{spec.name}-#{spec.version}.#{ext}"
    puts "Releasing #{File.basename(file)}..."
    
    ruby_forge.add_release(spec.rubyforge_project, spec.name, spec.version, file)
  end
end

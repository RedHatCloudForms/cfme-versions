begin
  require "bundler/gem_tasks"
rescue LoadError
end

require "rake/testtask"

desc "Setup the project for building the gem"
task :setup do
  exec 'gem install bundler'
end

desc "Open an irb console"
task :console do
  exec 'irb -r ./cfme-versions'
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

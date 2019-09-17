require "rake/clean"
require "rake/testtask"

CLEAN.add "*.gem"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

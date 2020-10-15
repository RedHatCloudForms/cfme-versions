require "bundler/gem_tasks"
require "rake/testtask"
require "rake/clean"

CLEAN << "crystal_build"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

namespace :crystal do
  directory "crystal_build"
  file      "crystal_build/cfme-versions" => "crystal_build" do
    sh "crystal build --release lib/cfme-versions.cr -o crystal_build/cfme-versions"
  end

  desc "Build the crystal "
  task :build => "crystal_build/cfme-versions"
end

task :default => ["crystal:build", :test]

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

task :default => [:spec]

desc "Run the specs."
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

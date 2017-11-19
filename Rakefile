require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'fileutils'

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run Rubocop on the code'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['spec/**/*.rb']
  task.fail_on_error = true
end

desc 'Build the site'
task :build do
  fail unless system 'jekyll build'
  Dir.glob('_build/groups/*.html').each do |old|
    new = old.sub('.html', '')
    FileUtils.mv old, new
  end
end

task default: [:spec, :rubocop, :build]

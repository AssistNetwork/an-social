require 'bundler'
require 'bundler/gem_tasks'

# -- Setup
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

# -- Install tasks
Bundler::GemHelper.install_tasks

# -- Style
#require 'rubocop/rake_task'
#desc 'Run Ruby style checks'
#RuboCop::RakeTask.new(:rubocop)

# -- Test
require 'rake/testtask'
desc 'Tests local'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# -- Defaults
task default: :test

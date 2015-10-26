# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|

  gem.authors     = ['Gabor Nagymajtenyi']
  gem.email       = ['gabor.nagymajtenyi@gmail.com']
  gem.description = 'Assist Network Backend Service'
  gem.summary     = 'Backend Service and API for Assist Network.'
  gem.homepage    = 'https://github.com/AssistNetwork'

  gem.name        = 'sample'
  gem.version     = '0.0.1'
  gem.require_paths = ['lib']

  # Ruby
  gem.required_ruby_version = '>= 2.2.0'
  gem.required_rubygems_version = '>= 2.2.0'

  # Dependencies

  gem.add_dependency 'rake'
  gem.add_dependency 'puma'
#  gem.add_dependency 'grape'
#  gem.add_dependency 'rack-cors'
#  gem.add_dependency 'sinatra'
  gem.add_dependency 'grape'
  gem.add_dependency 'json'
  gem.add_dependency 'omniauth'
  gem.add_dependency 'omniauth-oauth2'
  gem.add_dependency 'omniauth-oauth'
  gem.add_dependency 'omniauth-github'
  gem.add_dependency 'omniauth-facebook'
  gem.add_dependency 'omniauth-twitter'
  gem.add_dependency 'ohm'
  gem.add_dependency 'ohm-contrib'
  gem.add_dependency 'cutest'
  gem.add_dependency 'minitest'
  gem.add_dependency 'rack-test'
#  gem.add_dependency 'tilt'
  gem.add_dependency 'slim'
  gem.add_dependency 'pry'

# Files
#  unless ENV['DYNO'] # check whether we're running on Heroku or not
#    gem.files = `git ls-files`.split
#    gem.test_files = Dir['test/**/*']
#    gem.executables = Dir['bin/*'].map { |f| File.basename(f) }
#  end

end

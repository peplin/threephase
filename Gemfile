source 'http://rubygems.org'

gem 'rails', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'friendly_id', "~> 3.1"

gem "ruby-openid"
gem "rack-openid", ">=0.2.1", :require => "rack/openid"
gem "authlogic", :git => "git://github.com/odorcicd/authlogic.git", :branch => "rails3"
gem "oauth"
gem "oauth2"
gem "authlogic-connect"
gem "enumerated_attribute"
gem "haml"
gem "dynamic_form"
gem "seed-fu", :git => "git://github.com/peplin/seed-fu.git", :branch => "rails3"
gem "resque"

# Deploy with Capistrano
# gem 'capistrano'

group :test, :development do
  gem 'shoulda'
  gem 'rcov'
  gem 'rspec-rails', ">= 2.0.0.beta.20"

  if RUBY_VERSION < '1.9'
    gem "ruby-debug"
  else
    gem 'ruby-debug19', :require => 'ruby-debug'
  end

  gem 'factory_girl'
  gem 'single_test'
  gem 'mocha'
  gem 'hirb'
  gem 'autotest'
  gem 'autotest-inotify'
end

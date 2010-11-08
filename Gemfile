source 'http://rubygems.org'

gem 'rails', '3.0.0'

gem 'friendly_id', "~> 3.1"
gem "ruby-openid"
gem "rack-openid", ">=0.2.1", :require => "rack/openid"
gem "authlogic", :git => "git://github.com/odorcicd/authlogic.git",
    :branch => "rails3"
gem "oauth"
gem "oauth2"
gem "authlogic-connect"
gem "enumerated_attribute"
gem "haml"
gem "dynamic_form"
gem "seed-fu", :git => "git://github.com/peplin/seed-fu.git",
    :branch => "rails3"
gem "resque"
gem "resque-scheduler"

group :production do
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'shoulda'
  gem 'rcov'
  gem 'rspec', ">= 2.0.1"
  gem 'rspec-rails', ">= 2.0.1"
  gem 'silent-postgres'

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

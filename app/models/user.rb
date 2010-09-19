class User < ActiveRecord::Base
  has_many :maps
  has_many :regions
  has_many :games, :through => :regions
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
  end
end

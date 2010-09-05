class User < ActiveRecord::Base
  has_many :maps
  has_many :regions
  has_many :games, :through => :regions
  validates_presence_of :email
  validates_format_of :email,
      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end

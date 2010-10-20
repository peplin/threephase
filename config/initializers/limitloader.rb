require 'limitloader'

class ActiveRecord::Base
  def self.acts_as_limited
    include LimitLoader
  end
end


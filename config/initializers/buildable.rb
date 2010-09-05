require 'buildable'

class ActiveRecord::Base
  def self.acts_as_technical_component
    include Buildable
  end
end


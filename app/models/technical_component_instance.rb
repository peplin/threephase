class TechnicalComponentInstance < ActiveRecord::Base
  self.inheritance_column = :instance_type
end

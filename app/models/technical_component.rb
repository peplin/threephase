class TechnicalComponent < ActiveRecord::Base
  self.inheritance_column = :component_type
  has_many :repairs
  has_many :contract_negotiations
  belongs_to :user

end

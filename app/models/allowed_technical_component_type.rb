class AllowedTechnicalComponentType < ActiveRecord::Base
  belongs_to :game
  belongs_to :technical_component
end

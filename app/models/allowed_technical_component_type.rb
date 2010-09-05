class AllowedTechnicalComponentType < ActiveRecord::Base
  belongs_to :game
  belongs_to :buildable, :polymorphic => true
end

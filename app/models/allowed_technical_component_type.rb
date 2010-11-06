class AllowedTechnicalComponentType < ActiveRecord::Base
  self.inheritance_column = :component_type
  belongs_to :buildable, :polymorphic => true
  belongs_to :game

  validates :game, :presence => true

  def to_s
    buildable
  end
end

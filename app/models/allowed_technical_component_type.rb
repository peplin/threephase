class AllowedTechnicalComponentType < ActiveRecord::Base
  self.inheritance_column = :component_type
  belongs_to :buildable, :polymorphic => true
  belongs_to :game

  validates :game, :presence => true
end

class AllowedGeneratorType < AllowedTechnicalComponentType
  belongs_to :generator_type, :foreign_key => "buildable_id"
end

class AllowedStorageDeviceType < AllowedTechnicalComponentType
  belongs_to :storage_device_type, :foreign_key => "buildable_id"
end

class AllowedLineType < AllowedTechnicalComponentType
  belongs_to :line_type, :foreign_key => "buildable_id"
end

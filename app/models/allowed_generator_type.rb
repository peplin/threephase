class AllowedGeneratorType < AllowedTechnicalComponentType
  belongs_to :generator_type, :foreign_key => "buildable_id"
end

class Line < TechnicalComponentInstance
  belongs_to :line_type, :foreign_key => "buildable_id"
end

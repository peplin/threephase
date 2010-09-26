class LineTypesController < TechnicalComponentsController
  def component_type
    LineType
  end

  def destroy_redirect_path
    line_types_path
  end
end

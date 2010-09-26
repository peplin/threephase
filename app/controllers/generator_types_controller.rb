class GeneratorTypesController < TechnicalComponentsController
  def component_type
    GeneratorType
  end

  def destroy_redirect_path
    generator_types_path
  end
end

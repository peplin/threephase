module NaturalResources
  NATURAL_RESOURCES = [:coal, :oil, :natural_gas, :sun, :wind, :water]

  def attribute_for_index index
    "#{index.to_s}_index"
  end

  def natural_resource_index(resource)
    send(attribute_for_index(resource))
  end
end


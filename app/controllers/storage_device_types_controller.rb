class StorageDeviceTypesController < TechnicalComponentsController
  def component_type
    StorageDeviceType
  end

  def destroy_redirect_path
    storage_device_types_path
  end
end

module ApplicationHelper
  def titlecase str
    str.gsub(/\b\w/){$&.upcase}
  end

  def slider(attribute, instance, params=nil)
    unit = params[:unit] or nil
    prepend = params[:prepend] or false

    value = instance.send(attribute)
    unitized_value = value
    if unit
      if unit == "%"
        unitized_value = "#{value}%"
      else
        if prepend
          unitized_value = "#{unit}#{value}"
        else
          unitized_value = "#{value} #{unit}"
        end
      end
    end

    haml_tag ".fieldpair" do
      haml_tag :label,
          (params[:display_name] or titlecase(attribute.to_s.humanize)),
          :for => attribute
      haml_tag "span.label", unitized_value, :name => attribute
      haml_tag "input.label", :id => attribute, :type => :hidden,
          :name => "#{instance.class.name.underscore}[#{attribute}]",
          :value => value
      haml_tag ".slider", :rel => attribute,
          "data-min" => (params[:min] or instance.class.minimum_for(attribute)),
          "data-max" => (params[:max] or instance.class.maximum_for(attribute)),
          "data-unit" => unit,
          "data-prepend" => prepend ? 1 : 0,
          "data-disabled" => params[:disabled] ? 1 : 0,
          "data-step" => params[:step] or 1
    end
  end

  def percentage_slider(attribute, instance, display_name=nil, params)
    slider attribute, instance,
        params.update({:unit => "%", :display_name => display_name})
  end

  def title title=nil
    if title
      @title = "#{title} - Threephase"
    else
      @title
    end
    content_for(:title) { @title }
  end
end

module ApplicationHelper
  def titlecase str
    str.gsub(/\b\w/){$&.upcase}
  end

  def slider(attribute, instance, params=nil)
    unit = params[:unit] or nil
    display_name = params[:display_name] or nil
    prepend = params[:prepend] or false
    disabled = params[:disabled] or false
    step = params[:step] or 1

    value = instance.send(attribute)
    unitized_value = value
    if unit
      if unit == "%"
        unitized_value = "#{value}%"
      else
        unitized_value = "#{unit}#{value}" if prepend
        unitized_value = "#{value} #{unit}" if not prepend
      end
    end

    haml_tag ".fieldpair" do
      haml_tag :label, (display_name or titlecase(attribute.to_s.humanize)),
          :for => attribute
      haml_tag "span.label", unitized_value, :name => attribute
      haml_tag "input.label", :id => attribute, :type => :hidden,
          :name => "#{instance.class.name.underscore}[#{attribute}]",
          :value => value
      haml_tag ".slider", :rel => attribute,
          "data-min" => instance.class.minimum_for(attribute),
          "data-max" => instance.class.maximum_for(attribute),
          "data-unit" => unit,
          "data-prepend" => prepend ? 1 : 0,
          "data-disabled" => disabled ? 1 : 0,
          "data-step" => step
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

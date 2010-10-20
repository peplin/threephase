module ApplicationHelper
  def titlecase str
    str.gsub(/\b\w/){$&.upcase}
  end

  def slider(attribute, instance, params=nil)
    unit = params[:unit] or nil
    display_name = params[:display_name] or nil
    prepend = params[:prepend] or false

    value = instance.send(attribute)
    if unit
      if unit == "%"
        value = "#{value}%"
      else
        value = "#{unit}#{value}" if prepend
        value = "#{value} #{unit}" if not prepend
      end
    end

    haml_tag ".fieldpair" do
      haml_tag :label, (display_name or titlecase(attribute.to_s.humanize)),
          :for => attribute
      haml_tag "span.label", value, :id => attribute
      haml_tag "input.label", :id => attribute, :type => :hidden,
          :name => "#{instance.class.name.underscore}[#{attribute}]",
          :value => value
      haml_tag ".slider", :rel => attribute,
          "data-min" => instance.class.minimum_for(attribute),
          "data-max" => instance.class.maximum_for(attribute),
          "data-unit" => unit
    end
  end

  def percentage_slider(attribute, instance, display_name=nil)
    slider attribute, instance, {:unit => "%", :display_name => display_name}
  end
end

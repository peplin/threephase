module Buildable
  def self.included(base)
    base.has_one :technical_component, :as => :buildable, :autosave => true
    base.validate :technical_component_must_be_valid
    base.alias_method_chain :technical_component, :autobuild
    base.extend ClassMethods
    base.define_technical_component_accessors
  end

  def technical_component_with_autobuild
    technical_component_without_autobuild || build_technical_component
  end

  def method_missing(meth, *args, &blk)
    technical_component.send(meth, *args, &blk)
  rescue NoMethodError
    super
  end

  module ClassMethods
    def define_technical_component_accessors
      all_attributes = TechnicalComponent.content_columns.map(&:name)
      ignored_attributes = ["created_at", "updated_at", "buildable_type"]
      attributes_to_delegate = all_attributes - ignored_attributes
      attributes_to_delegate.each do |attrib|
        class_eval <<-RUBY
          def #{attrib}
            technical_component.#{attrib}
          end

          def #{attrib}=(value)
            self.technical_component.#{attrib} = value
          end

          def #{attrib}?
            self.technical_component.#{attrib}?
          end
        RUBY
      end
    end
  end

protected
  def technical_component_must_be_valid
    unless technical_component.valid?
      technical_component.errors.each do |attr, message|
        errors.add(attr, message)
      end
    end
  end
end

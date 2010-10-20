module LimitLoader
  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    MAXIMUM_OPTIONS = [:less_than_or_equal_to, :less_than]
    MINIMUM_OPTIONS = [:greater_than_or_equal_to, :greater_than]

    def maximum_for attribute
      validators.each do |validator|
        next unless validator.attributes.include? attribute

        if validator.class == PercentageValidator
          return 100
        end

        ClassMethods::MAXIMUM_OPTIONS.each do |option|
          return validator.options[option] if validator.options[option]
        end
      end
      return nil
    end

    def minimum_for attribute
      validators.each do |validator|
        next unless validator.attributes.include? attribute

        if validator.class == PercentageValidator
          return 0
        end

        ClassMethods::MINIMUM_OPTIONS.each do |option|
          return validator.options[option] if validator.options[option]
        end
      end
      return nil
    end
  end
end

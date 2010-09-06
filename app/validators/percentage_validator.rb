class PercentageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless not value or (value >= 0 and value <= 100)
      record.errors.add attribute, 'is not a valid percentage (0-100)'
    end
  end
end

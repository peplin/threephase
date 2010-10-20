class LineEndpointValidator < ActiveModel::Validator
  def validate record
    starting = record.send(options[:start])
    ending = record.send(options[:end])
    if starting and ending and starting == ending
      record.errors[:base] << "start and endpoint cannot be the same"
    end
  end
end

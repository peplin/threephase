class Fuel < ActiveRecord::Base
  has_many :generator_types
  has_many :fuel_contracts
end

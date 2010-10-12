class Customer < ActiveRecord::Base
  belongs_to :city

  validates :x, :presence => true
  validates :y, :presence => true
  validates :power_factor, :presence => true
  validates :city, :presence => true

  def to_s
    "(#{x}, #{y}), p.f. #{power_factor}"
  end
end

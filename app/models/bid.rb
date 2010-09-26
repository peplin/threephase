class Bid < ActiveRecord::Base
  belongs_to :generator
  validates_presence_of :price

  validates :generator, :presence => true

  def to_s
    "$#{price} for #{generator}"
  end
end

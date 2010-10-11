class Bid < ActiveRecord::Base
  belongs_to :generator

  validates :price, :presence => true
  validates :generator, :presence => true

  def to_s
    "$#{price} for #{generator} @ #{created_at}"
  end
end

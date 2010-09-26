class Contract < ActiveRecord::Base
  belongs_to :generator
  has_many :offers

  validates :reason, :presence => true
  validates :amount, :presence => true
  validates :generator, :presence => true

  def to_s
    "#{reason} with #{offers.count} offers"
  end
end

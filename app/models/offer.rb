class Offer < ActiveRecord::Base
  belongs_to :contract

  validates_presence_of :proposed_amount
  validates :contract, :presence => true

  def to_s
    "#{proposed_amount}? #{accepted}"
  end
end

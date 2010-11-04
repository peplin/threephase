class Bid < ActiveRecord::Base
  belongs_to :generator

  validates :price, :presence => true, :numericality => {:greater_than => 0}
  validates :generator, :presence => true
  validate :must_be_auction_regulation, :once_per_day

  def to_s
    "$#{price} for #{generator} @ #{created_at}"
  end

  private

  def must_be_auction_regulation
    if not generator.takes_bids?
      errors[:generator] << ("the current economic regulation "
          "doesn't require bidding in")
    end if generator
  end

  def once_per_day
    last_bid = generator.bids.order(:created_at).first if generator
    if last_bid.created_at > 1.day.ago
      errors[:base] << "only one bid allowed per day"
    end if last_bid
  end
end

class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :bids
  has_many :accepted_bids, :conditions => "accepted = TRUE"

  validates :generator_type, :presence => true
end

class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :contracts
  has_many :offers, :through => :contracts
  has_many :bids

  validates :generator_type, :presence => true
end

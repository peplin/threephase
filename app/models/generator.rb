class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :foreign_key => "buildable_id"
  has_many :contract_negotiations
  has_many :contract_offers, :through => :contract_negotiations
  has_many :bids

  validates :generator_type, :presence => true
end

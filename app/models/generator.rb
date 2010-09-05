class Generator < TechnicalComponentInstance
  belongs_to :generator_type, :as => buildable
  has_many :contract_negotiations
  has_many :contract_offers, :through => :contract_negotiations
  has_many :bids
end

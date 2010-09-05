class Region < ActiveRecord::Base
  has_many :research_advancements
  has_many :proposed_fuel_contracts, :foreign_key => 'proposing_region_id'
  has_many :received_fuel_contracts, :foreign_key => 'receiving_region_id'
  has_many :interstate_lines
  belongs_to :map
  belongs_to :game
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :research_budget
  validates_numericality_of :research_budget, :greater_than_or_equal_to => 0
end

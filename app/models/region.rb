class Region < ActiveRecord::Base
  has_many :research_advancements
  has_many :outgoing_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "outgoing_region_id"
  has_many :incoming_interstate_lines, :class_name => "InterstateLine",
      :foreign_key => "incoming_region_id"
  belongs_to :map
  belongs_to :game
  belongs_to :user
  has_friendly_id :name, :use_slug => true, :scope => :game

  validates :name, :presence => true
  validates :research_budget, :presence => true,
      :numericality => {:greater_than_or_equal_to => 0}
  validates :map, :presence => true
  validates :game, :presence => true
  validates :user, :presence => true

  def interstate_lines
    InterstateLine.with_region(id)
  end
end

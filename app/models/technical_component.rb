class TechnicalComponent < ActiveRecord::Base
  belongs_to :buildable, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  has_many :technical_component_instances, :as => :buildable

  validates :name, :presence => true
  validates :peak_capacity_min, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :peak_capacity_max, :presence => true, :numericality => {
      :greater_than_or_equal_to => 1}
  validates :average_capacity, :presence => true, :percentage => true
  validates :mtbf, :presence => true
  validates :mttr, :presence => true
  validates :repair_cost, :presence => true, :percentage => true
  validates :workforce, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :area, :presence => true, :numericality => {
      :greater_than => 0}
  validates :capital_cost_min, :presence => true, :numericality => {
      :greater_than_or_equal_to => 1}
  validates :capital_cost_max, :presence => true, :numericality => {
      :greater_than => 0}
  validates :environmental_disruptiveness, :presence => true,
      :percentage => true
  validates :waste_disposal_cost_min, :presence => true, :numericality => {
      :greater_than => 0}
  validates :waste_disposal_cost_max, :presence => true, :numericality => {
      :greater_than => 1}
  validates :noise, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
  validates :lifetime, :presence => true, :numericality => {
      :greater_than_or_equal_to => 0}
end

require 'spec_helper'

describe TechnicalComponent do
  it { should belong_to :user }
  it { should belong_to :buildable }
  it { should validate_presence_of :name }
  it { should validate_presence_of :peak_capacity_min }
  it { should validate_presence_of :peak_capacity_max }
  it { should validate_presence_of :average_capacity }
  it { should validate_presence_of :mtbf }
  it { should validate_presence_of :mttr }
  it { should validate_presence_of :repair_cost }
  it { should validate_presence_of :workforce }
  it { should validate_presence_of :area }
  it { should validate_presence_of :capitol_cost_min }
  it { should validate_presence_of :capitol_cost_max }
  it { should validate_presence_of :environmental_disruptiveness }
  it { should validate_presence_of :waste_disposal_cost_min }
  it { should validate_presence_of :waste_disposal_cost_max }
  it { should validate_presence_of :noise }
  it { should validate_presence_of :operating }
  it { should validate_presence_of :lifetime }
end

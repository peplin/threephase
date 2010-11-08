class Step
  @queue = :state_step

  def self.perform(state_id)
    state = State.find(state_id)
    state.deduct_operating_costs
    state.charge_customers
  end
end


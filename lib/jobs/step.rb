class Step
  @queue = :state_step

  def self.perform(state_id)
    state = State.find(state_id)
    logger.info "Stepping #{state}"
    state.step
    state.save
    logger.info "Done stepping #{state}"
  end
end


class Step
  @queue = :state_step

  def self.perform(state_id)
    state = State.find(state_id)
    state.step
    state.save
  end
end

class StepAllGames
  @queue = :game_step

  def self.perform
    Game.all.each do |game|
      game.step_async
    end
  end
end

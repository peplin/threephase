class GeneratorsController < TechnicalComponentInstancesController

  def costs
    find_instance
    game = @instance.game
    costs = game.time.now.range(game.time.now -
        [10.days, game.time.now - game.time.epoch].min, 1.day).collect do |t|
      time = game.time.at(t, false)
      @instance.marginal_cost(time)
    end

    if costs.empty?
      costs << @instance.marginal_cost
    end

    (10 - costs.length).times do
      costs << costs.first
    end

    respond_to do |format|
      # TODO would like to not resort to this, but using respond_to in this
      # controller subclass FUBARs the parent
      format.json { render :json => costs }
    end
  end

  private

  def component_type
    Generator
  end
end

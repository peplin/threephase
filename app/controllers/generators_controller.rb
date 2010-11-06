class GeneratorsController < TechnicalComponentInstancesController

  def costs
    find_instance
    game = @instance.game
    costs = game.time.now.range([10.days.ago, game.time.epoch].max, 1.day
        ).collect do |t|
      time = game.time.at(t)
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

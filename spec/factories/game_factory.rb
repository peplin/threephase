Factory.define :game do |g|
  g.regulation_type :unregulated
  g.after_create { |game| attach_state game }
end

Factory.define :invalid_game, :parent => :game do |g|
  g.max_players -2
end

Factory.define :another_game, :parent => :game do |g|
  g.max_players 42
end

Factory.define :started_game, :parent => :game do |g|
  g.started Time.now
end

def attach_state game
  Factory(:state, :game => game)
end

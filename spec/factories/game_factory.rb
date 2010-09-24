Factory.define :game do |g|
  g.regulation_type :unregulated
end

Factory.define :invalid_game, :parent => :game do |g|
  g.max_players -2
end

Factory.define :huge_game, :parent => :game do |g|
  g.max_players 42
end

Factory.define :started_game, :parent => :game do |g|
  g.started Time.now
end

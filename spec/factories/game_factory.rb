Factory.define :game do |g|
  g.regulation_type :ror
  g.nickname "A Game"
  g.created_at 2.hours.ago # since game time depends on epoch being in the past
end

Factory.define :invalid_game, :parent => :game do |g|
  g.max_players -2
end

Factory.define :another_game, :parent => :game do |g|
  g.max_players 42
end

Factory.define :auction_game, :parent => :game do |g|
  g.regulation_type :auction
end

Factory.define :started_game, :parent => :game do |g|
  g.started Time.now
end

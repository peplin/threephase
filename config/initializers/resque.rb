require 'resque'
require 'resque_scheduler'

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port,
    :password => uri.password)

Resque.schedule = YAML.load_file('config/resque-schedule.yml')

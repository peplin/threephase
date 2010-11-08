require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  Dir["#{File.dirname(__FILE__)}/../jobs/**/*.rb"].each {|f| require f}
end


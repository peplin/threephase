task "resque:setup" => :environment do
  Dir["#{File.dirname(__FILE__)}/../jobs/**/*.rb"].each {|f| require f}
end


def in_memory_database?
  ::Rails.env == "test" and Threephase::Application.config.database_configuration['test']['database'] == ':memory:'
end

if in_memory_database?
  puts "connecting to in-memory database ..."
  ActiveRecord::Base.establish_connection(Threephase::Application.config.database_configuration['test'])
  puts "building in-memory database from db/schema.rb ..."
  load "#{Rails.root}/db/schema.rb"
end

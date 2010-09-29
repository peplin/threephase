Autotest.add_discovery { "rails" }
Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |at|
  at.add_exception(%r{^\./\.git})
  at.add_exception(%r{^\./db})
  at.add_exception(%r{^\./log})
  at.add_exception(%r{^\./tmp})
  at.add_exception(%r{^\./rerun.txt})
  at.add_exception(%r{^\./Gemfile.lock})
end

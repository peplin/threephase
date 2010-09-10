spec_prereq = Rails.root.join('config', 'database.yml').exist? ? "db:test:prepare" : :noop

namespace :spec do
  desc "Run all specs with rcov"
  RSpec::Core::RakeTask.new(:rcov => spec_prereq) do |t|
    t.rcov = true
    t.rcov_opts = %w{--rails --exclude gems\/,spec\/,features\/}
  end
end

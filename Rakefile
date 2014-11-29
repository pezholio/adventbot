$:.unshift File.join( File.dirname(__FILE__), "lib")

require 'rspec/core/rake_task'
require 'adventbot'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :adventbot do
  task :tweet do
    Adventbot.tweet
  end
end

require 'vcr'
require 'timecop'
require 'adventbot'
require 'pry'
require 'ignore_env'

VCR.configure do |c|
  (ENV.keys-$ignore_env).select { |x| x =~ /\A[A-Z_]*\Z/ }.each do |key|
    c.filter_sensitive_data("<#{key}>") { ENV[key] }
  end
  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = { :record => :once }
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.order = "random"
end

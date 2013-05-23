require 'simplecov'
SimpleCov.start

require 'rspec'
require 'fakeweb'
require 'runscope'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.order = "random"
end

FakeWeb.allow_net_connect = false

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'webmock/rspec'
require 'runscope'

RSpec.configure do |config|
  config.color_enabled = true
  config.order = "random"
end

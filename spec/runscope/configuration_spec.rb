require 'spec_helper'

describe Runscope::Configuration do
  after(:each) do
    Runscope.reset
  end

  it 'should set options when passed a block' do
    domains = ["api.stackexchange.com", /\S+\.desk\.com/]
    bucket = "1234abcd"

    Runscope.configure do |config|
      config.domains = domains
      config.bucket = bucket
    end

    Runscope.enabled.should eq(true)
    Runscope.domains.should eq(domains)
    Runscope.bucket.should eq(bucket)
  end
end

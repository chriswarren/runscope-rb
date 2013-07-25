require 'spec_helper'

describe Runscope::Configuration do
  let(:domains){["api.stackexchange.com", /\S+\.desk\.com/]}
  let(:bucket){"1234abcd"}

  before(:each) do
    Runscope.configure do |config|
      config.domains = domains
      config.bucket = bucket
    end
  end

  after(:each) do
    Runscope.reset
  end

  it{expect(Runscope.enabled).to eq(true)}
  it{expect(Runscope.domains).to eq(domains)}
  it{expect(Runscope.bucket).to eq(bucket)}

  it{expect(Runscope.options).to include({bucket: bucket})}
  it{expect(Runscope.options).to include({domains: domains})}
  it{expect(Runscope.options).to include({enabled: true})}
end

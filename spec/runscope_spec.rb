require 'spec_helper'

describe Runscope do
  context "basic methods" do
    it 'should return correct version string' do
      Runscope.version_string.should eq("Runscope version #{Runscope::VERSION}")
    end
  end

  context 'monitoring' do
    before(:each) do
      Runscope.domains = ["api.stackexchange.com", /\S+\.desk\.com/]
    end

    after(:each) do
      Runscope.reset
    end

    context "when enabled" do
      before(:each) do
        Runscope.enabled = true
      end

      it "should be true if the domain is monitored" do
        Runscope.monitor?("api.stackexchange.com").should eq(true)
      end

      it "should be false if the domain is not monitored" do
        Runscope.monitor?("api.twitter.com").should eq(false)
      end
    end

    context "when disabled" do
      before(:each) do
        Runscope.enabled = false
      end

      it "should be false if the domain is monitored" do
        Runscope.monitor?("api.stackexchange.com").should eq(false)
      end

      it "should be false if the domain is not monitored" do
        Runscope.monitor?("api.twitter.com").should eq(false)
      end
    end
  end

  context 'matching domains' do
    before(:each) do
      Runscope.domains = ["api.stackexchange.com", /\S+\.desk\.com/]
    end

    it "should match when stored as a string" do
      Runscope.monitor_domain?("api.stackexchange.com").should eq(true)
    end

    it "should match when stored as a Regexp" do
      Runscope.monitor_domain?("test.desk.com").should eq(true)
    end

    it "should not match domains that aren't set" do
      Runscope.monitor_domain?("api.twitter.com").should eq(false)
    end

    it "should raise an error if no domains are set" do
      Runscope.domains = nil
      expect {
        Runscope.monitor_domain?("api.stackexchange.com")
      }.to raise_error(NoDomainsSetError)
    end
  end

  context 'generating a runscope proxy domain' do
    before(:each) do
      @bucket = "1234abcd"
      Runscope.bucket = @bucket
    end

    it "should return a domain to runscope" do
      Runscope.proxy_domain("api.stackexchange.com").should
        eq("api-stackexchange-com-#{@bucket}.runscope.net")
    end

    it "should raise an error if no bucket is set" do
      Runscope.bucket = nil
      expect {
        Runscope.proxy_domain("api.stackexchange.com")
      }.to raise_error(BucketNotSetError)
    end
  end
end

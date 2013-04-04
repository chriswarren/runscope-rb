require 'spec_helper'

describe Net::HTTP do
  context "outgoing requests" do
    before(:each) do
      @domains = ["api.stackexchange.com", /\S+\.desk\.com/]
      @bucket = "1234abcd"

      Runscope.configure do |config|
        config.domains = @domains
        config.bucket = @bucket
      end
    end

    context "to a url monitored by runscope" do
      it "should modify a to a url that matches a string" do
        FakeWeb.register_uri(:get, "http://api-stackexchange-com-#{@bucket}.runscope.net", :body => "test")
        Net::HTTP.get_response(URI.parse("http://api.stackexchange.com"))
      end

      it "should modify a request to a url that matches a regexp" do
        FakeWeb.register_uri(:get, "http://test-desk-com-#{@bucket}.runscope.net", :body => "test")
        Net::HTTP.get_response(URI.parse("http://test.desk.com"))
      end
    end

    context "to a url not monitored by runscope" do
      it "should not modify a request to a url that doesn't match" do
        FakeWeb.register_uri(:get, "http://api.twitter.com", :body => "test")
        Net::HTTP.get_response(URI.parse("http://api.twitter.com"))
      end
    end
  end
end

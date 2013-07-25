require 'spec_helper'

describe Runscope do
  describe '#version_string' do
    it 'should return correct version string' do
      Runscope.version_string.should eq("Runscope version #{Runscope::VERSION}")
    end
  end

  describe '#monitor?' do
    before(:each){
      Runscope.domains = ["api.stackexchange.com", /\S+\.desk\.com/]
    }
    after(:each){ Runscope.reset }
    context "when enabled" do
      before{ Runscope.enabled = true }
      it{expect(Runscope.monitor?("api.stackexchange.com")).to eq(true)}
      it{expect(Runscope.monitor?("api.twitter.com")).to eq(false)}
    end

    context "when disabled" do
      before(:each){ Runscope.enabled = false }
      it{expect(Runscope.monitor?("api.stackexchange.com")).to eq(false)}
      it{expect(Runscope.monitor?("api.twitter.com")).to eq(false)}
    end
  end

  describe '#monitor_domain?' do
    before(:each){
      Runscope.domains = ["api.stackexchange.com", /\S+\.desk\.com/]
    }

    it{expect(Runscope.monitor_domain?("api.stackexchange.com")).to eq(true)}
    it{expect(Runscope.monitor_domain?("test.desk.com")).to eq(true)}
    it{expect(Runscope.monitor_domain?("api.twitter.com")).to eq(false)}
    it "should raise an error if no domains are set" do
      Runscope.domains = nil
      expect {Runscope.monitor_domain?("api.stackexchange.com")}.to(
        raise_error(NoDomainsSetError)
      )
    end
  end

  describe '#proxy_domain' do
    before(:each) do
      @bucket = "1234abcd"
      Runscope.bucket = @bucket
    end

    it{expect(Runscope.proxy_domain("api.stackexchange.com")).to(
      eq("api-stackexchange-com-#{@bucket}.runscope.net")
    )}

    it "should raise an error if no bucket is set" do
      Runscope.bucket = nil
      expect {
        Runscope.proxy_domain("api.stackexchange.com")
      }.to raise_error(BucketNotSetError)
    end
  end

  describe '#add_port_header_to_request' do
    let(:port){ 4000 }
    let(:request){ Net::HTTP::Get.new('http://example.com') }
    it 'sets the Runscope-Request-Port header' do
      modified_request = Runscope.add_port_header_to_request(request, port)
      expect(modified_request.instance_variable_get('@header')).to(
        include({'Runscope-Request-Port' => "#{port}"})
      )
    end
  end

  describe '#is_non_standard_port?' do
    it{expect(Runscope.is_non_standard_port?(80)).to be_false}
    it{expect(Runscope.is_non_standard_port?(443)).to be_false}
    it{expect(Runscope.is_non_standard_port?(6000)).to be_true}
  end
end

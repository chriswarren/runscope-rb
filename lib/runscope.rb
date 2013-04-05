require "runscope/version"
require "runscope/configuration"
require "ext/net_http"

module Runscope
  extend Configuration

  def self.version_string
    "Runscope version #{Runscope::VERSION}"
  end

  def self.monitor?(address)
    Runscope.enabled? && Runscope.monitor_domain?(address)
  end

  def self.monitor_domain?(address)
    Runscope.domains.any? do |domain|
      if domain.is_a?(String)
        address == domain
      elsif domain.is_a?(Regexp)
        address =~ domain
      end
    end
  end

  def self.proxy_domain(address)
    subdomain = address.gsub(".","-")
    "#{subdomain}-#{Runscope.bucket}.runscope.net"
  end

  def self.enabled?
    Runscope.enabled
  end

end

require "runscope/version"
require "runscope/configuration"
require "ext/net_http"

module Runscope
  extend Configuration

  def self.version_string
    "Runscope version #{Runscope::VERSION}"
  end

  def self.monitor?(address)
    enabled? && monitor_domain?(address)
  end

  def self.monitor_domain?(address)
    raise NoDomainsSetError unless domains
    domains.any? do |domain|
      if domain.is_a?(String)
        address == domain
      elsif domain.is_a?(Regexp)
        address =~ domain
      end
    end
  end

  def self.proxy_domain(address)
    raise BucketNotSetError unless bucket
    subdomain = address.gsub(".","-")
    "#{subdomain}-#{bucket}.runscope.net"
  end

  def self.add_port_header_to_request(request, port)
    headers = request.instance_variable_get('@header')
    request.instance_variable_set(
      '@header',
      headers.merge('Runscope-Request-Port' => port)
    )
    request
  end

  def self.enabled?
    Runscope.enabled
  end
end

class RunscopeError < StandardError; end
class BucketNotSetError < RunscopeError; end
class NoDomainsSetError < RunscopeError; end

require 'net/http'
require 'net/https'

module Net
  class HTTP

    def request_with_runscope(request, body=nil, &block)
      if ::Runscope.monitor?(self.address)
        @address = ::Runscope.proxy_domain(self.address)
      end
      request_without_runscope(request, body, &block)
    end
    alias_method :request_without_runscope, :request
    alias_method :request, :request_with_runscope

  end
end

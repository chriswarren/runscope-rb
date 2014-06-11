require 'net/http'

module Net
  class HTTP
    def request_with_runscope(req, body = nil, &block)
      if ::Runscope.monitor?(self.address)
        if ::Runscope.is_non_standard_port?(self.port)
          req = ::Runscope.add_port_header_to_request(req, @port)
        end
      end

      request_without_runscope(req, body, &block)
    end
    alias_method_chain :request, :runscope

    def connect_with_runscope
      if ::Runscope.monitor?(self.address)
        if ::Runscope.is_non_standard_port?(self.port)
          @port = 80
        end
        @address = ::Runscope.proxy_domain(self.address)
      end
      connect_without_runscope
    end
    alias_method_chain :connect, :runscope
  end
end

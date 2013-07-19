class Net::HTTP

  def request_with_runscope(request, body=nil, &block)
    if ::Runscope.monitor?(self.address)
      if @port
        request = ::Runscope.add_port_header_to_request(request, @port)
        @port = nil
      end
      @address = ::Runscope.proxy_domain(self.address)
    end
    request_without_runscope(request, body, &block)
  end
  alias_method 'request_without_runscope', 'request'
  alias_method 'request', 'request_with_runscope'
end

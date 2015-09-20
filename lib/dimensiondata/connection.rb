module DimensionData
  module Connection
    def build_request(type, endpoint, mcpversion, query = nil, body = nil, xml=true)
      if mcpversion == 1
        uri = @api_base + "/oec/0.9" + endpoint
      else
        uri = @api_base + "/caas/2.0" + endpoint
      end
      append_query(uri, query) if query
      if (xml)
        request = Typhoeus::Request.new(
          uri,
          method: type,
          body: body,
          userpwd: "#{@username}:#{@password}",
          headers: { 'Content-Type' =>'text/xml', 'User-Agent' => 'CaaS Ruby SDK' },
          ssl_verifypeer: false
        )
      else
        request = Typhoeus::Request.new(
          uri,
          method: type,
          body: body,
          userpwd: "#{@username}:#{@password}",
          headers: {  'User-Agent' => 'CaaS Ruby SDK' },
          ssl_verifypeer: false
        )
      end
    end

    def append_query(uri, query)
      if uri.include?('?')
        uri << '&'
      else
        uri << '?'
      end
      uri << query
    end


    def perform_request(request)
      log "\nrequesting #{request.url}...", :yellow
      request.run
    end

    def log_response(request, response)
      if response.success?
      elsif response.timed_out?
        log "ERROR\n-----", :red
        log "got a time out"
      elsif response.code == 0
        # Could not get an http response, something's wrong.
        log "ERROR\n-----", :red
        log response.return_message
      else
        # Received a non-successful http response.
        log "ERROR\n-----", :red
        log "HTTP request failed: " + response.code.to_s, :red
        log response.body, :yellow
      end
    end
  end
end

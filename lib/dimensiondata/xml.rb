module DimensionData
  module XML
    def xml_header
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' "\n"
    end

    def parse_response_xml_body(body)
      # we'll not use 'KeyToSymbol' because it doesn't symbolize the keys for node attributes
      opts = { 'ForceArray' => false, 'ForceContent' => false }
      hash = XmlSimple.xml_in(body, opts)
      hash.delete_if {|k, v| k =~ /(xmlns|xmlns:ns)/ } # removing the namespaces from response
      Hashie::Mash.new(underscore_keys(hash))
    rescue Exception => e
      log "Impossible to convert XML to hash. Error: #{e.message}", :red
      raise e
    end

    def build_request_simple_body(params)
      params = camelize_keys(params)
      #simple construction of post body...
      body = params.map { |k, v| "#{k}=#{v}&" }
      body.join
    end

    def build_request_xml_body(schema, tag, params, mcpver)
      params = camelize_keys(params)
      if mcpver == 1
        schema_url = "http://oec.api.opsource.net/schemas/#{schema}"
      else
        schema_url = "urn:didata.com:api:cloud:types"
      end

      xml = xml_header
      xml += "<#{tag} xmlns=\"#{schema_url}\">\n"
      params.each do |k, value|
        if (!value.nil?)
          if (value.is_a?(Hash))
            if (value[:attribute])
              attribhash = value[:attribute]
              value.delete(:attribute)
              xml += build_xml_helper_attribute(k, value, attribhash.keys[0], attribhash.values[0])
            else
              xml += build_xml_helper(k, value)
            end
          else
            xml += build_xml_helper(k, value)
          end

          xml += "\n"
        end

      end
      xml += "</#{tag}>\n"
    end

    def build_xml_helper(key, value)
        result = "<#{key}>"
        if value.is_a?(Hash)
            value.each do |k, v|
                result += build_xml_helper(k,v)
            end
        else
            result += "#{value}"
        end
        result += "</#{key}>"
    end
    def build_xml_helper_attribute(key, value, attribute, attribute_value)
      result = "<#{key} #{attribute}='#{attribute_value}'>"
      if value.is_a?(Hash)
        value.each do |k, v|
          result += build_xml_helper(k,v)
        end
      else
        result += "#{value}"
      end
      result += "</#{key}>"
    end

  end
end

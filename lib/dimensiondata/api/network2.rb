module DimensionData::API
  class Network2 < Core
    def list_domains
      mcpversion 2
      org_endpoint '/network/networkDomain'
      get
    end

    def list_domains_in_location(location_id)
      mcpversion 2
      org_endpoint '/network/networkDomain'
      query_params(datacenterId: location_id)
      get
    end
    def get_domain(networkdomain_id)
      mcpversion 2
      org_endpoint "/network/networkDomain/#{networkdomain_id}"
      get
    end
    def list_vlans
      mcpversion 2
      org_endpoint '/network/vlan'
      get
    end
    def list_vlans_in_domain(domain_id)
      mcpversion 2
      org_endpoint '/network/vlan'
      query_params(networkDomainId: domain_id)
      get
    end
    def get_vlan(vlan_id)
      mcpversion 2
      org_endpoint "/network/vlan/#{vlan_id}"
      get
    end
  end
end

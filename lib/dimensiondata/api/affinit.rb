module DimensionData::API
  class Affinity < Core
    def list(options = {})
      org_endpoint "/antiAffinityRule"
      query_params options
      get
    end
    def create(server1_id, server2_id)
      org_endpoint "/antiAffinityRule"
      xml_params(
          tag: "NewAntiAffinityRule",
          schema: "server",
          serverId: server1_id,
          serverId: server2_id
      )
      post
    end
    def delete(rule_id)
      org_endpoint "/antiAffinityRule/#{rule_id}?delete"
      get
    end

  end
end



module DimensionData::API
  class Directory < Core
    def data_center_list
      mcpversion 2
      org_endpoint "/infrastructure/datacenter"
      get
    end
    def data_center_with_id(id)
      mcpversion 2
      org_endpoint "/infrastructure/datacenter"
      query_params(id: id)
      get
    end

  end
end
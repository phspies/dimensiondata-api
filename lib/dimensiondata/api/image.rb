module DimensionData::API
  class Image < Core
    def template_list_in_location(datacenter)
      endpoint "/base/imageWithDiskSpeed?location=#{datacenter}"
      get
    end
    def software_labels_in_location(datacenter)
      org_endpoint "/softwarelabel&location=#{datacenter}"
      get
    end
    def template_labels_in_location(datacenter)
      org_endpoint "/imageWithDiskSpeed?&location=#{datacenter}"
      get
    end
    def show_by_name(name, options = {})
      options[:name] = name
      single(deployed_list(options))
    end
    def deployed_list(options = {})
      endpoint "/#{org_id}/image/deployed"
      query_params options
      get
    end
    def show(image_id)
      endpoint "/#{org_id}/image/#{image_id}"
      get
    end
  end
end
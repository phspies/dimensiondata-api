module DimensionData::API
  class Server2 < Core
    def list(options = {})
      mcpversion 2
      org_endpoint "/serverWithState"
      query_params options
      get
    end

    def list_deployed_with_disks_in_location(datacenter, options = {})
      mcpversion 2
      org_endpoint "/serverWithBackup?location=#{datacenter}"
      query_params options
      get
    end

    def list_deployed_with_disks_in_network(network_id, options = {})
      mcpversion 2
      org_endpoint "/network/#{network_id}/server/deployedWithDisks"
      query_params options
      get
    end

    def show(server_id)
      mcpversion 2
      org_endpoint "/server/server/#{server_id}"
      get
    end

    def create_with_ip(name, description, networkDomainId, privateIp, image_id, image_password, started=false)
      mcpversion 2
      org_endpoint "/server/deployServer"
      xml_params(
          tag: "deployServer",
          schema: "urn:didata.com:api:cloud:types",
          name: name,
          description: description,
          imageId: image_id,
          start: started,
          administratorPassword: image_password,
          networkInfo: { attribute: {networkDomainId: networkDomainId}, primaryNic: { privateIpv4: privateIp  } }
      )
      post
    end

    def create_with_vlan(name, description, networkDomainId, vlan_id, image_id, image_password, started=false)
      mcpversion 2
      org_endpoint "/server/deployServer"
      xml_params(
        tag: "deployServer",
        schema: "urn:didata.com:api:cloud:types",
        name: name,
        description: description,
        imageId: image_id,
        start: started,
        administratorPassword: image_password,
        networkInfo: {attribute: {networkDomainId: networkDomainId}, primaryNic: { vlanId: vlan_id  } }

      )
      post
    end
    def delete(server_id)
      org_endpoint "/server/#{server_id}?delete"
      get
    end

    # memory in GB, we'll make sure it's in 1024's
    def modify(server_id, name = nil, description = nil, cpu_count = nil, memory = nil)
      simple_params(
        name: name,
        description: description,
        cpuCount: cpu_count,
        memory: (memory * 1024)
      )
      org_endpoint "/server/#{server_id}"
      post_simple
    end

    def start(server_id)
      org_endpoint "/server/#{server_id}?start"
      get
    end

    def shutdown(server_id)
      org_endpoint "/server/#{server_id}?shutdown"
      get
    end

    def poweroff(server_id)
      org_endpoint "/server/#{server_id}?poweroff"
      get
    end

    def reboot(server_id)
      org_endpoint "/server/#{server_id}?reboot"
      get
    end

    def reset(server_id)
      org_endpoint "/server/#{server_id}?reset"
      get
    end

    # amount is # of GBs
    def add_storage(server_id, amount)
      org_endpoint "/server/#{server_id}?addLocalStorage"
      query_params(amount: amount)
      get
    end

    def remove_storage(server_id, disk_id)
      org_endpoint "/server/#{server_id}/disk/#{disk_id}?delete"
      get
    end
    def expand_storage(server_id, disk_id, newsize)
      org_endpoint "/server/#{server_id}/disk/#{disk_id}/changeSize"
      xml_params(
          tag: "ChangeDiskSize",
          schema: "server",
          newSizeGb: newsize
      )
      post
    end
    def change_storage_tier(server_id, disk_id, speed)
      org_endpoint "/server/#{server_id}/disk/#{disk_id}/changeSpeed"
      xml_params(
          tag: "ChangeDiskSpeed",
          schema: "server",
          speed: speed
      )
      post
    end
    def update_tools(server_id)
      org_endpoint "/server/#{server_id}?updateVMwareTools"
      get
    end
  end
end

#### ServersWithState
# <ServersWithState
# xmlns="http://oec.api.dimensiondata.net/schemas/server"
# totalCount="320"
# pageCount="250"
# pageNumber="1"
# pageSize="250">
# <!--Zero or more repetitions:-->
# <serverWithState id="c325fe04-7711-4968-962e-c88784eb2" location="NA1">
# <name>Production LAMP Server</name>
# <!--Optional:-->
# <description>Main web application server.</description>
# <operatingSystem id="REDHAT564" displayName="REDHAT5/64" type="UNIX"/>
# <cpuCount>2</cpuCount>
# <memoryMb>4096</memoryMb>
# <!-- one or more repetitions:-->
# <disk id="x445fe05-7113-4988-9d2e-cbjt78eb2" scsiId="0" sizeGb="50"
# speed="STANDARD" state="NORMAL"/>
# <disk id="ef49974c-87d0-400f-aa32-ee43559fdb1b" scsiId="1" sizeGb="150"
# speed="STANDARD" state="NORMAL"/>
# <!--Zero or more repetitions:-->
# <softwareLabel>REDHAT5ES64</softwareLabel>
# <!--Optional:-->
# <sourceImageId>5a18d6f0-eaca-11e1-8340-d93da27669ab</sourceImageId>
# <networkId>xb632974c-87d0-400faa32-hb43559flk765</networkId>
# © 2013 Dimension Data Cloud Solutions
# 69
# <machineName>10-157-3-125</machineName>
# <privateIp>10.157.3.125</privateIp>
# <!--Optional:-->
# <publicIp>206.80.63.208</publicIp>
# <created>2012-07-02T10:43:31.000Z</created>
# <isStarted>false</isStarted>
# <isDeployed>true</isDeployed>
# <state>PENDING_CHANGE</state>
# <!--Zero or more repetitions:-->
# <machineStatus name="vmwareToolsRunningStatus">
# <value>RUNNING</value>
# </machineStatus>
# <!--Optional:-->
# <status>
# <action>START_SERVER</action>
# <requestTime>2012-09-26T08:36:28</requestTime>
# <userName>btaylor</userName>
# <!--Optional:-->
# <numberOfSteps>3</numberOfSteps>
# <!--Optional:-->
# <updateTime>2012-09-26T08:37:28</updateTime>
# <!--Optional:-->
# <step>
# <name>Waiting for operation</name>
# <number>3</number>
# <!--Optional:-->
# <percentComplete>3</percentComplete>
# </step>
# <!--Optional: (present only if the last operation failed and left
# the server in a locked state) -->
# <failureReason>Message Value</failureReason>
# </status>
# </serverWithState>
# </ServersWithState>

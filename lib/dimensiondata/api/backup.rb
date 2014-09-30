module Dimensiondata::API
  class Backup < Core
    @serviceplans = ["Essentials", "Advanced", "Enterprise"]
    @alerttriggers = ["ON_FAILURE", "ON_SUCCESS", "ON_SUCCESS_OR_FAILURE", "ON_SUCCESS"]

    def add(serverId, type, policy, schedule, alert_trigger, alert_email)
      @trigger = {}
      @trigger.compare_by_identity
      case alert_trigger
        when String
          @trigger = {trigger: alert_trigger}
        when Array
          alert_trigger.each {|a| @trigger["trigger"] = a }
      end

      raise Error, "Alert trigger not available" if !@alerttriggers.include?(alert_trigger)
      org_endpoint "/server/#{serverId}/backup/client"
      xml_params(
          tag: "NewBackupClient",
          schema: "backup",
          type: type,
          storagePolicyName: policy,
          schedulePolicyName: schedule,
          {alerting: @trigger, emailAddress: alert_email}
      )
      post
    end
    def enable(serverId, servicePlan)
      raise Error, "Service plan not available" if !@serviceplans.include?(servicePlan)
      org_endpoint "/server/#{serverId}/backup"
      xml_params(
          tag: "NewBackup",
          schema: "backup",
          servicePlan: servicePlan
      )
      post
    end
    def modify_backupclient(serverId, clientId, policy, schedule, alert_trigger, alert_email)
      @trigger = {}
      @trigger.compare_by_identity
      case alert_trigger
        when String
          @trigger = {trigger: alert_trigger}
        when Array
          alert_trigger.each {|a| @trigger["trigger"] = a }
      end

      raise Error, "Alert trigger not available" if !@alerttriggers.include?(alert_trigger)
      org_endpoint "/server/#{serverId}/backup/client/#{clientId}/modify"
      xml_params(
          tag: "ModifyBackupClient",
          schema: "backup",
          storagePolicyName: policy,
          schedulePolicyName: schedule,
          {alerting: @trigger, emailAddress: alert_email}
      )
      post
    end
    def modify_serviceplan(serverId, servicePlan)
      raise Error, "Service plan not available" if !@serviceplans.include?(servicePlan)
      org_endpoint "/server/#{serverId}/backup/modify"
      xml_params(
          tag: "ModifyBackup",
          schema: "backup",
          servicePlan: servicePlan
      )
      post

    end
    def show_types(serverId)
      org_endpoint "/server/#{serverId}/backup/client/type"
      get
    end
    def show_policies(serverId)
      org_endpoint "/server/#{serverId}/backup/client/storagePolicy"
      get
    end
    def show_schedules(serverId)
      org_endpoint "/server/#{serverId}/backup/client/schedulePolicy"
      get
    end
    def disable(serverId)
      org_endpoint "/server/#{serverId}/backup?disable"
      get
    end
    def remove(serverId, clientId)
      org_endpoint "/server/#{serverId}/backup/client/#{clientId}?remove"
      get
    end
  end
end



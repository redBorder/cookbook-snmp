#
# Cookbook Name:: snmp
# Provider::config
#
# Copyright 2010, Eric G. Wolfe
# Based on Eric G. Wolfe recipe for snmp. Adapted to be a provider and to
# work on redborder environments by Pablo Nebrera and Alberto Rodriguez
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :add do
  begin
    community = new_resource.community
    cdomain = new_resource.cdomain
    hostname = new_resource.hostname
    snmp_username = new_resource.snmp_username
    snmp_pass = new_resource.snmp_pass
    config_dir = new_resource.config_dir

    yum_package "net-snmp" do
      action :upgrade
    end

    directory config_dir do
      owner "root"
      group "root"
      mode "0755"
    end

    template "/etc/sysconfig/snmpd" do
      source "snmpd.erb"
      owner "root"
      group "root"
      mode 0644
      retries 2
      cookbook "snmp"
      variables(:hostname => hostname)
      notifies :restart, "service[snmpd]", :delayed
    end

    template "#{config_dir}/snmpd.conf" do
      mode 0644
      owner "root"
      group "root"
      source "snmpd.conf.erb"
      retries 2
      cookbook "snmp"
      variables(:community => community,
                :cdomain => cdomain,
                :hostname => hostname,
                :snmp_pass => snmp_pass, 
                :snmp_username => snmp_username)                
      notifies :restart, "service[snmpd]", :delayed
    end

    service "snmpd" do
      ignore_failure true
      supports :status => true, :reload => true, :restart => true
      action([:start, :enable])
    end

  rescue
    Chef::Log.error(e.message)
  end  
end

action :remove do
  begin
    service "snmpd" do
      ignore_failure true
      supports :status => true, :reload => true, :restart => true
      action([:stop, :disable])
    end
  end
end



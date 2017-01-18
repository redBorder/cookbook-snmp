#
# Cookbook Name:: snmp
# Recipe:: default
#

snmp_config "Configure snmp" do 
	hostname node["hostname"]
	cdomain "redborder.cluster"
	action :add
end
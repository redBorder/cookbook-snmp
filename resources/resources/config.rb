# Cookbook Name:: snmp
#
# Resource:: config
#

actions :add, :remove
default_action :add

attribute :community, :kind_of => String, :default => "redborder"
attribute :cdomain, :kind_of => String, :default => "redborder.cluster"
attribute :hostname, :kind_of => String, :default => "localhost"
attribute :snmp_username, :kind_of => String, :default => "redborder"
attribute :snmp_pass, :kind_of => String, :default => "redborderP@ssw0rd"
attribute :config_dir, :kind_of => String, :default => "/etc/snmp"
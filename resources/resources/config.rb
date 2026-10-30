# Cookbook:: snmp
# Resource:: config

actions :add, :remove
default_action :add

attribute :community, kind_of: String, default: 'redBorder'
attribute :cdomain, kind_of: String, default: 'redborder.cluster'
attribute :hostname, kind_of: String, default: 'localhost'
attribute :snmp_username, kind_of: String, default: 'redborder'
attribute :snmp_pass, kind_of: String, default: 'redborderP@ssw0rd'
attribute :config_dir, kind_of: String, default: '/etc/snmp'
attribute :trap_sensors, kind_of: Array, default: []
attribute :sensor_uuid, kind_of: String
attribute :cloud, kind_of: [TrueClass, FalseClass], default: false
attribute :trap_sink, kind_of: String

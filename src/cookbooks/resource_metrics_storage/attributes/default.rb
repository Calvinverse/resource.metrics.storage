# frozen_string_literal: true

#
# CONSULTEMPLATE
#

default['consul_template']['config_path'] = '/etc/consul-template.d/conf'
default['consul_template']['template_path'] = '/etc/consul-template.d/templates'

#
# FIREWALL
#

# Allow communication on the loopback address (127.0.0.1 and ::1)
default['firewall']['allow_loopback'] = true

# Do not allow MOSH connections
default['firewall']['allow_mosh'] = false

# Do not allow WinRM (which wouldn't work on Linux anyway, but close the ports just to be sure)
default['firewall']['allow_winrm'] = false

# No communication via IPv6 at all
default['firewall']['ipv6_enabled'] = false

#
# INFLUXDB
#

default['influxdb']['version'] = '1.7.2-1'

default['influxdb']['lib_file_path'] = '/srv/influxdb'
default['influxdb']['meta_file_path'] = "#{node['influxdb']['lib_file_path']}/meta"
default['influxdb']['data_file_path'] = "#{node['influxdb']['lib_file_path']}/data"
default['influxdb']['wal_file_path'] = "#{node['influxdb']['lib_file_path']}/wal"
default['influxdb']['collectd_path'] = "#{node['influxdb']['lib_file_path']}/collectd"
default['influxdb']['collectd_types_path'] = "#{node['influxdb']['collectd_path']}/types.db"

default['influxdb']['service_user'] = 'influxdb'
default['influxdb']['service_group'] = 'influxdb'

default['influxdb']['port']['admin'] = 8083
default['influxdb']['port']['backup'] = 8088
default['influxdb']['port']['collectd'] = 25_826
default['influxdb']['port']['graphite'] = 2003
default['influxdb']['port']['http'] = 8086

# For influxdb versions >= 1.0.x
# ref: https://docs.influxdata.com/influxdb/v1.0/administration/config/
default['influxdb']['config'] = {
  'reporting-disabled' => false,
  'bind-address' => ":#{node['influxdb']['port']['backup']}",
  'meta' => {
    'dir' => node['influxdb']['meta_file_path'],
    'retention-autocreate' => true,
    'logging-enabled' => true
  },
  'data' => {
    'dir' => node['influxdb']['data_file_path'],
    'engine' => 'tsm1',
    'wal-dir' => node['influxdb']['wal_file_path'],
    'wal-logging-enabled' => true,
    'query-log-enabled' => true,
    'cache-max-memory-size' => 524_288_000,
    'cache-snapshot-memory-size' => 26_214_400,
    'cache-snapshot-write-cold-duration' => '1h0m0s',
    'compact-full-write-cold-duration' => '24h0m0s',
    'max-points-per-block' => 0,
    'trace-logging-enabled' => false
  },
  'coordinator' => {
    'write-timeout' => '10s',
    'max-concurrent-queries' => 0,
    'query-timeout' => '0',
    'log-queries-after' => '0',
    'max-select-point' => 0,
    'max-select-series' => 0,
    'max-select-buckets' => 0
  },
  'retention' => {
    'enabled' => true,
    'check-interval' => '30m0s'
  },
  'shard-precreation' => {
    'enabled' => true,
    'check-interval' => '10m0s',
    'advance-period' => '30m0s'
  },
  'monitor' => {
    'store-enabled' => true,
    'store-database' => '_internal',
    'store-interval' => '10s'
  },
  'admin' => {
    'enabled' => true,
    'bind-address' => ":#{node['influxdb']['port']['admin']}",
    'https-enabled' => false,
    'https-certificate' => node['influxdb']['ssl_cert_file_path']
  },
  'http' => {
    'enabled' => true,
    'bind-address' => ":#{node['influxdb']['port']['http']}",
    'auth-enabled' => false,
    'log-enabled' => true,
    'write-tracing' => false,
    'pprof-enabled' => false,
    'https-enabled' => false,
    'https-certificate' => node['influxdb']['ssl_cert_file_path'],
    'https-private-key' => '',
    'max-row-limt' => 10_000,
    'max-connection-limit' => 0,
    'shared-secret' => '',
    'realm' => 'InfluxDB'
  },
  'logging' => {
    'format' => 'logfmt',
    'level' => 'debug',
    'suppress-logo' => true
  },
  'subscriber' => {
    'enabled' => true,
    'http-timeout' => '30s'
  },
  'graphite' => [
    {
      'enabled' => true,
      'bind-address' => ":#{node['influxdb']['port']['graphite']}",
      'database' => 'graphite',
      'protocol' => 'tcp'
    }
  ],
  'collectd' => [
    {
      'enabled' => true,
      'bind-address' => ":#{node['influxdb']['port']['collectd']}",
      'database' => 'collectd',
      'typesdb' => node['influxdb']['collectd_types_path']
    }
  ],
  'udp' => [
    {
      'enabled' => false
    }
  ],
  'continuous_queries' => {
    'log-enabled' => true,
    'enabled' => true,
    'run-interval' => '1s'
  }
}

default['influxdb']['telegraf']['consul_template_inputs_file'] = 'telegraf_influxdb_inputs.ctmpl'

#
# TELEGRAF
#

default['telegraf']['service_user'] = 'telegraf'
default['telegraf']['service_group'] = 'telegraf'
default['telegraf']['config_directory'] = '/etc/telegraf/telegraf.d'

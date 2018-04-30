# frozen_string_literal: true

#
# Cookbook Name:: resource_metrics_storage
# Recipe:: influxdb
#
# Copyright 2017, P. van der Velde
#

#
# CREATE DATA PATH
#

influxdb_service_path = node['influxdb']['lib_file_path']
directory influxdb_service_path do
  action :create
  recursive true
end

#
# INSTALL INFLUXDB
#

include_recipe 'influxdb::default'

#
# SET PERMISSIONS ON DATA PATH
#

influxdb_meta_path = node['influxdb']['meta_file_path']
directory influxdb_meta_path do
  action :create
  group node['influxdb']['service_group']
  mode '775'
  owner node['influxdb']['service_user']
  recursive true
end

influxdb_data_path = node['influxdb']['data_file_path']
directory influxdb_data_path do
  action :create
  group node['influxdb']['service_group']
  mode '775'
  owner node['influxdb']['service_user']
  recursive true
end

influxdb_wal_path = node['influxdb']['wal_file_path']
directory influxdb_wal_path do
  action :create
  group node['influxdb']['service_group']
  mode '775'
  owner node['influxdb']['service_user']
  recursive true
end

influx_collectd_path = node['influxdb']['collectd_path']
directory influx_collectd_path do
  action :create
  group node['influxdb']['service_group']
  mode '775'
  owner node['influxdb']['service_user']
  recursive true
end

#
# COLLECTD TYPES FILE
#

influx_collectd_types_path = node['influxdb']['collectd_types_path']
file influx_collectd_types_path do
  action :create
  content <<~DB
    absolute                value:ABSOLUTE:0:U
    apache_bytes            value:DERIVE:0:U
    apache_connections      value:GAUGE:0:65535
    apache_idle_workers     value:GAUGE:0:65535
    apache_requests         value:DERIVE:0:U
    apache_scoreboard       value:GAUGE:0:65535
    ath_nodes               value:GAUGE:0:65535
    ath_stat                value:DERIVE:0:U
    backends                value:GAUGE:0:65535
    bitrate                 value:GAUGE:0:4294967295
    blocked_clients         value:GAUGE:0:U
    bucket                  value:GAUGE:0:U
    bytes                   value:GAUGE:0:U
    cache_eviction          value:DERIVE:0:U
    cache_operation         value:DERIVE:0:U
    cache_ratio             value:GAUGE:0:100
    cache_result            value:DERIVE:0:U
    cache_size              value:GAUGE:0:1125899906842623
    capacity                value:GAUGE:0:U
    ceph_bytes              value:GAUGE:U:U
    ceph_latency            value:GAUGE:U:U
    ceph_rate               value:DERIVE:0:U
    changes_since_last_save value:GAUGE:0:U
    charge                  value:GAUGE:0:U
    clock_last_meas         value:GAUGE:0:U
    clock_last_update       value:GAUGE:U:U
    clock_mode              value:GAUGE:0:U
    clock_reachability      value:GAUGE:0:U
    clock_skew_ppm          value:GAUGE:0:1000000
    clock_state             value:GAUGE:0:U
    clock_stratum           value:GAUGE:0:U
    compression             uncompressed:DERIVE:0:U, compressed:DERIVE:0:U
    compression_ratio       value:GAUGE:0:2
    connections             value:DERIVE:0:U
    conntrack               value:GAUGE:0:4294967295
    contextswitch           value:DERIVE:0:U
    cookies                 value:DERIVE:0:U
    count                   value:GAUGE:0:U
    counter                 value:COUNTER:U:U
    cpu                     value:DERIVE:0:U
    cpu_affinity            value:GAUGE:0:1
    cpufreq                 value:GAUGE:0:U
    current                 value:GAUGE:U:U
    current_connections     value:GAUGE:0:U
    current_sessions        value:GAUGE:0:U
    delay                   value:GAUGE:-1000000:1000000
    delay_rate              value:GAUGE:0:U
    derive                  value:DERIVE:0:U
    df                      used:GAUGE:0:1125899906842623, free:GAUGE:0:1125899906842623
    df_complex              value:GAUGE:0:U
    df_inodes               value:GAUGE:0:U
    dilution_of_precision   value:GAUGE:0:U
    disk_error              value:GAUGE:0:U
    disk_io_time            io_time:DERIVE:0:U, weighted_io_time:DERIVE:0:U
    disk_latency            read:GAUGE:0:U, write:GAUGE:0:U
    disk_merged             read:DERIVE:0:U, write:DERIVE:0:U
    disk_octets             read:DERIVE:0:U, write:DERIVE:0:U
    disk_ops                read:DERIVE:0:U, write:DERIVE:0:U
    disk_ops_complex        value:DERIVE:0:U
    disk_time               read:DERIVE:0:U, write:DERIVE:0:U
    dns_answer              value:DERIVE:0:U
    dns_notify              value:DERIVE:0:U
    dns_octets              queries:DERIVE:0:U, responses:DERIVE:0:U
    dns_opcode              value:DERIVE:0:U
    dns_qtype               value:DERIVE:0:U
    dns_qtype_cached        value:GAUGE:0:4294967295
    dns_query               value:DERIVE:0:U
    dns_question            value:DERIVE:0:U
    dns_rcode               value:DERIVE:0:U
    dns_reject              value:DERIVE:0:U
    dns_request             value:DERIVE:0:U
    dns_resolver            value:DERIVE:0:U
    dns_response            value:DERIVE:0:U
    dns_transfer            value:DERIVE:0:U
    dns_update              value:DERIVE:0:U
    dns_zops                value:DERIVE:0:U
    domain_state            state:GAUGE:0:U, reason:GAUGE:0:U
    drbd_resource           value:DERIVE:0:U
    duration                seconds:GAUGE:0:U
    email_check             value:GAUGE:0:U
    email_count             value:GAUGE:0:U
    email_size              value:GAUGE:0:U
    energy                  value:GAUGE:U:U
    energy_wh               value:GAUGE:U:U
    entropy                 value:GAUGE:0:4294967295
    errors                  value:DERIVE:0:U
    evicted_keys            value:DERIVE:0:U
    expired_keys            value:DERIVE:0:U
    fanspeed                value:GAUGE:0:U
    file_handles            value:GAUGE:0:U
    file_size               value:GAUGE:0:U
    files                   value:GAUGE:0:U
    filter_result           value:DERIVE:0:U
    flow                    value:GAUGE:0:U
    fork_rate               value:DERIVE:0:U
    frequency               value:GAUGE:0:U
    frequency_error         value:GAUGE:-1000000:1000000
    frequency_offset        value:GAUGE:-1000000:1000000
    fscache_stat            value:DERIVE:0:U
    gauge                   value:GAUGE:U:U
    hash_collisions         value:DERIVE:0:U
    http_request_methods    value:DERIVE:0:U
    http_requests           value:DERIVE:0:U
    http_response_codes     value:DERIVE:0:U
    humidity                value:GAUGE:0:100
    if_collisions           value:DERIVE:0:U
    if_dropped              rx:DERIVE:0:U, tx:DERIVE:0:U
    if_errors               rx:DERIVE:0:U, tx:DERIVE:0:U
    if_multicast            value:DERIVE:0:U
    if_octets               rx:DERIVE:0:U, tx:DERIVE:0:U
    if_packets              rx:DERIVE:0:U, tx:DERIVE:0:U
    if_rx_dropped           value:DERIVE:0:U
    if_rx_errors            value:DERIVE:0:U
    if_rx_octets            value:DERIVE:0:U
    if_rx_packets           value:DERIVE:0:U
    if_tx_dropped           value:DERIVE:0:U
    if_tx_errors            value:DERIVE:0:U
    if_tx_octets            value:DERIVE:0:U
    if_tx_packets           value:DERIVE:0:U
    invocations             value:DERIVE:0:U
    io_octets               rx:DERIVE:0:U, tx:DERIVE:0:U
    io_ops                  read:DERIVE:0:U, write:DERIVE:0:U
    io_packets              rx:DERIVE:0:U, tx:DERIVE:0:U
    ipc                     value:GAUGE:0:U
    ipt_bytes               value:DERIVE:0:U
    ipt_packets             value:DERIVE:0:U
    irq                     value:DERIVE:0:U
    job_stats               value:DERIVE:0:U
    latency                 value:GAUGE:0:U
    links                   value:GAUGE:0:U
    load                    shortterm:GAUGE:0:5000, midterm:GAUGE:0:5000, longterm:GAUGE:0:5000
    memory_bandwidth        value:DERIVE:0:U
    md_disks                value:GAUGE:0:U
    memcached_command       value:DERIVE:0:U
    memcached_connections   value:GAUGE:0:U
    memcached_items         value:GAUGE:0:U
    memcached_octets        rx:DERIVE:0:U, tx:DERIVE:0:U
    memcached_ops           value:DERIVE:0:U
    memory                  value:GAUGE:0:281474976710656
    memory_lua              value:GAUGE:0:281474976710656
    memory_throttle_count   value:DERIVE:0:U
    multimeter              value:GAUGE:U:U
    mutex_operations        value:DERIVE:0:U
    mysql_bpool_bytes       value:GAUGE:0:U
    mysql_bpool_counters    value:DERIVE:0:U
    mysql_bpool_pages       value:GAUGE:0:U
    mysql_commands          value:DERIVE:0:U
    mysql_handler           value:DERIVE:0:U
    mysql_innodb_data       value:DERIVE:0:U
    mysql_innodb_dblwr      value:DERIVE:0:U
    mysql_innodb_log        value:DERIVE:0:U
    mysql_innodb_pages      value:DERIVE:0:U
    mysql_innodb_row_lock   value:DERIVE:0:U
    mysql_innodb_rows       value:DERIVE:0:U
    mysql_locks             value:DERIVE:0:U
    mysql_log_position      value:DERIVE:0:U
    mysql_octets            rx:DERIVE:0:U, tx:DERIVE:0:U
    mysql_select            value:DERIVE:0:U
    mysql_sort              value:DERIVE:0:U
    mysql_sort_merge_passes value:DERIVE:0:U
    mysql_sort_rows         value:DERIVE:0:U
    mysql_slow_queries      value:DERIVE:0:U
    nfs_procedure           value:DERIVE:0:U
    nginx_connections       value:GAUGE:0:U
    nginx_requests          value:DERIVE:0:U
    node_octets             rx:DERIVE:0:U, tx:DERIVE:0:U
    node_rssi               value:GAUGE:0:255
    node_stat               value:DERIVE:0:U
    node_tx_rate            value:GAUGE:0:127
    objects                 value:GAUGE:0:U
    operations              value:DERIVE:0:U
    operations_per_second   value:GAUGE:0:U
    packets                 value:DERIVE:0:U
    pending_operations      value:GAUGE:0:U
    percent                 value:GAUGE:0:100.1
    percent_bytes           value:GAUGE:0:100.1
    percent_inodes          value:GAUGE:0:100.1
    perf                    value:DERIVE:0:U
    pf_counters             value:DERIVE:0:U
    pf_limits               value:DERIVE:0:U
    pf_source               value:DERIVE:0:U
    pf_state                value:DERIVE:0:U
    pf_states               value:GAUGE:0:U
    pg_blks                 value:DERIVE:0:U
    pg_db_size              value:GAUGE:0:U
    pg_n_tup_c              value:DERIVE:0:U
    pg_n_tup_g              value:GAUGE:0:U
    pg_numbackends          value:GAUGE:0:U
    pg_scan                 value:DERIVE:0:U
    pg_xact                 value:DERIVE:0:U
    ping                    value:GAUGE:0:65535
    ping_droprate           value:GAUGE:0:100
    ping_stddev             value:GAUGE:0:65535
    players                 value:GAUGE:0:1000000
    pools                   value:GAUGE:0:U
    power                   value:GAUGE:U:U
    pressure                value:GAUGE:0:U
    protocol_counter        value:DERIVE:0:U
    ps_code                 value:GAUGE:0:9223372036854775807
    ps_count                processes:GAUGE:0:1000000, threads:GAUGE:0:1000000
    ps_cputime              user:DERIVE:0:U, syst:DERIVE:0:U
    ps_data                 value:GAUGE:0:9223372036854775807
    ps_disk_octets          read:DERIVE:0:U, write:DERIVE:0:U
    ps_disk_ops             read:DERIVE:0:U, write:DERIVE:0:U
    ps_pagefaults           minflt:DERIVE:0:U, majflt:DERIVE:0:U
    ps_rss                  value:GAUGE:0:9223372036854775807
    ps_stacksize            value:GAUGE:0:9223372036854775807
    ps_state                value:GAUGE:0:65535
    ps_vm                   value:GAUGE:0:9223372036854775807
    pubsub                  value:GAUGE:0:U
    queue_length            value:GAUGE:0:U
    records                 value:GAUGE:0:U
    requests                value:GAUGE:0:U
    response_code           value:GAUGE:0:U
    response_time           value:GAUGE:0:U
    root_delay              value:GAUGE:U:U
    root_dispersion         value:GAUGE:U:U
    route_etx               value:GAUGE:0:U
    route_metric            value:GAUGE:0:U
    routes                  value:GAUGE:0:U
    satellites              value:GAUGE:0:U
    segments                value:GAUGE:0:65535
    serial_octets           rx:DERIVE:0:U, tx:DERIVE:0:U
    signal_noise            value:GAUGE:U:0
    signal_power            value:GAUGE:U:0
    signal_quality          value:GAUGE:0:U
    smart_attribute         current:GAUGE:0:255, worst:GAUGE:0:255, threshold:GAUGE:0:255, pretty:GAUGE:0:U
    smart_badsectors        value:GAUGE:0:U
    smart_powercycles       value:GAUGE:0:U
    smart_poweron           value:GAUGE:0:U
    smart_temperature       value:GAUGE:-300:300
    snr                     value:GAUGE:0:U
    spam_check              value:GAUGE:0:U
    spam_score              value:GAUGE:U:U
    spl                     value:GAUGE:U:U
    swap                    value:GAUGE:0:1099511627776
    swap_io                 value:DERIVE:0:U
    tcp_connections         value:GAUGE:0:4294967295
    temperature             value:GAUGE:U:U
    threads                 value:GAUGE:0:U
    time_dispersion         value:GAUGE:-1000000:1000000
    time_offset             value:GAUGE:-1000000:1000000
    time_offset_ntp         value:GAUGE:-1000000:1000000
    time_offset_rms         value:GAUGE:-1000000:1000000
    time_ref                value:GAUGE:0:U
    timeleft                value:GAUGE:0:U
    total_bytes             value:DERIVE:0:U
    total_connections       value:DERIVE:0:U
    total_events            value:DERIVE:0:U
    total_objects           value:DERIVE:0:U
    total_operations        value:DERIVE:0:U
    total_requests          value:DERIVE:0:U
    total_sessions          value:DERIVE:0:U
    total_threads           value:DERIVE:0:U
    total_time_in_ms        value:DERIVE:0:U
    total_values            value:DERIVE:0:U
    uptime                  value:GAUGE:0:4294967295
    users                   value:GAUGE:0:65535
    vcl                     value:GAUGE:0:65535
    vcpu                    value:GAUGE:0:U
    virt_cpu_total          value:DERIVE:0:U
    virt_vcpu               value:DERIVE:0:U
    vmpage_action           value:DERIVE:0:U
    vmpage_faults           minflt:DERIVE:0:U, majflt:DERIVE:0:U
    vmpage_io               in:DERIVE:0:U, out:DERIVE:0:U
    vmpage_number           value:GAUGE:0:4294967295
    volatile_changes        value:GAUGE:0:U
    voltage                 value:GAUGE:U:U
    voltage_threshold       value:GAUGE:U:U, threshold:GAUGE:U:U
    vs_memory               value:GAUGE:0:9223372036854775807
    vs_processes            value:GAUGE:0:65535
    vs_threads              value:GAUGE:0:65535

    #
    # Legacy types
    # (required for the v5 upgrade target)
    #
    arc_counts              demand_data:COUNTER:0:U, demand_metadata:COUNTER:0:U, prefetch_data:COUNTER:0:U, prefetch_metadata:COUNTER:0:U
    arc_l2_bytes            read:COUNTER:0:U, write:COUNTER:0:U
    arc_l2_size             value:GAUGE:0:U
    arc_ratio               value:GAUGE:0:U
    arc_size                current:GAUGE:0:U, target:GAUGE:0:U, minlimit:GAUGE:0:U, maxlimit:GAUGE:0:U
    mysql_qcache            hits:COUNTER:0:U, inserts:COUNTER:0:U, not_cached:COUNTER:0:U, lowmem_prunes:COUNTER:0:U, queries_in_cache:GAUGE:0:U
    mysql_threads           running:GAUGE:0:U, connected:GAUGE:0:U, cached:GAUGE:0:U, created:COUNTER:0:U
  DB
end

#
# ALLOW INFLUXDB THROUGH THE FIREWALL
#

influxdb_admin_port = node['influxdb']['port']['admin']
firewall_rule 'influxdb-admin' do
  command :allow
  description 'Allow InfluxDB admin traffic'
  dest_port influxdb_admin_port
  direction :in
end

influxdb_backup_port = node['influxdb']['port']['backup']
firewall_rule 'influxdb-backup' do
  command :allow
  description 'Allow InfluxDB backup traffic'
  dest_port influxdb_backup_port
  direction :in
end

influxdb_collectd_port = node['influxdb']['port']['collectd']
firewall_rule 'influxdb-collectd' do
  command :allow
  description 'Allow InfluxDB CollectD traffic'
  dest_port influxdb_collectd_port
  direction :in
end

influxdb_graphite_port = node['influxdb']['port']['graphite']
firewall_rule 'influxdb-graphite' do
  command :allow
  description 'Allow InfluxDB Graphite traffic'
  dest_port influxdb_graphite_port
  direction :in
end

influxdb_http_port = node['influxdb']['port']['http']
firewall_rule 'influxdb-http' do
  command :allow
  description 'Allow InfluxDB HTTP traffic'
  dest_port influxdb_http_port
  direction :in
end

influxdb_opentsdb_port = node['influxdb']['port']['opentsdb']
firewall_rule 'influxdb-opentsdb' do
  command :allow
  description 'Allow InfluxDB OpenTSDB traffic'
  dest_port influxdb_opentsdb_port
  direction :in
end

#
# CONSUL FILES
#

file '/etc/consul/conf.d/influxdb-backup.json' do
  action :create
  content <<~JSON
    {
      "services": [
        {
          "checks": [
            {
              "http": "http://localhost:#{influxdb_http_port}/ping",
              "id": "influxdb_backup_health_check",
              "interval": "30s",
              "method": "GET",
              "name": "Influx backup health check",
              "timeout": "5s"
            }
          ],
          "enableTagOverride": false,
          "id": "influxdb_backup",
          "name": "metrics",
          "port": #{influxdb_backup_port},
          "tags": [
            "backup"
          ]
        }
      ]
    }
  JSON
end

file '/etc/consul/conf.d/influxdb-collectd.json' do
  action :create
  content <<~JSON
    {
      "services": [
        {
          "checks": [
            {
              "http": "http://localhost:#{influxdb_http_port}/ping",
              "id": "influxdb_collectd_health_check",
              "interval": "30s",
              "method": "GET",
              "name": "Influx CollectD health check",
              "timeout": "5s"
            }
          ],
          "enableTagOverride": false,
          "id": "influxdb_collectd",
          "name": "metrics",
          "port": #{influxdb_collectd_port},
          "tags": [
            "collectd"
          ]
        }
      ]
    }
  JSON
end

file '/etc/consul/conf.d/influxdb-graphite.json' do
  action :create
  content <<~JSON
    {
      "services": [
        {
          "checks": [
            {
              "http": "http://localhost:#{influxdb_http_port}/ping",
              "id": "influxdb_graphite_health_check",
              "interval": "30s",
              "method": "GET",
              "name": "Influx Graphite health check",
              "timeout": "5s"
            }
          ],
          "enableTagOverride": false,
          "id": "influxdb_graphite",
          "name": "metrics",
          "port": #{influxdb_graphite_port},
          "tags": [
            "graphite"
          ]
        }
      ]
    }
  JSON
end

file '/etc/consul/conf.d/influxdb-http.json' do
  action :create
  content <<~JSON
    {
      "services": [
        {
          "checks": [
            {
              "http": "http://localhost:#{influxdb_http_port}/ping",
              "id": "influxdb_http_health_check",
              "interval": "30s",
              "method": "GET",
              "name": "Influx HTTP health check",
              "timeout": "5s"
            }
          ],
          "enableTagOverride": false,
          "id": "influxdb_http",
          "name": "metrics",
          "port": #{influxdb_http_port},
          "tags": [
            "http"
          ]
        }
      ]
    }
  JSON
end

file '/etc/consul/conf.d/influxdb-opentsdb.json' do
  action :create
  content <<~JSON
    {
      "services": [
        {
          "checks": [
            {
              "http": "http://localhost:#{influxdb_http_port}/ping",
              "id": "influxdb_opentsdb_health_check",
              "interval": "30s",
              "method": "GET",
              "name": "Influx OpenTSDB health check",
              "timeout": "5s"
            }
          ],
          "enableTagOverride": false,
          "id": "influxdb_opentsdb",
          "name": "metrics",
          "port": #{influxdb_opentsdb_port},
          "tags": [
            "opentsdb"
          ]
        }
      ]
    }
  JSON
end

#
# CONSUL-TEMPLATE FILES
#

consul_template_config_path = node['consul_template']['config_path']
consul_template_template_path = node['consul_template']['template_path']

telegraf_service = 'telegraf'
telegraf_config_directory = node['telegraf']['config_directory']
telegraf_influxdb_inputs_template_file = node['influxdb']['telegraf']['consul_template_inputs_file']
file "#{consul_template_template_path}/#{telegraf_influxdb_inputs_template_file}" do
  action :create
  content <<~CONF
    # Telegraf Configuration

    ###############################################################################
    #                            INPUT PLUGINS                                    #
    ###############################################################################

    # Read InfluxDB-formatted JSON metrics from one or more HTTP endpoints
    [[inputs.influxdb]]
      ## Works with InfluxDB debug endpoints out of the box,
      ## but other services can use this format too.
      ## See the influxdb plugin's README for more details.

      ## Multiple URLs from which to read InfluxDB-formatted JSON
      ## Default is "http://localhost:8086/debug/vars".
      urls = [
        "http://localhost:#{influxdb_http_port}/debug/vars"
      ]

      ## Optional SSL Config
      # ssl_ca = "/etc/telegraf/ca.pem"
      # ssl_cert = "/etc/telegraf/cert.pem"
      # ssl_key = "/etc/telegraf/key.pem"
      ## Use SSL but skip chain & host verification
      # insecure_skip_verify = false

      ## http request & header timeout
      timeout = "5s"
      [inputs.influxdb.tags]
        influxdb_database = "{{ keyOrDefault "config/services/metrics/databases/services" "services" }}"
  CONF
  mode '755'
end

file "#{consul_template_config_path}/telegraf_influxdb_inputs.hcl" do
  action :create
  content <<~HCL
    # This block defines the configuration for a template. Unlike other blocks,
    # this block may be specified multiple times to configure multiple templates.
    # It is also possible to configure templates via the CLI directly.
    template {
      # This is the source file on disk to use as the input template. This is often
      # called the "Consul Template template". This option is required if not using
      # the `contents` option.
      source = "#{consul_template_template_path}/#{telegraf_influxdb_inputs_template_file}"

      # This is the destination path on disk where the source template will render.
      # If the parent directories do not exist, Consul Template will attempt to
      # create them, unless create_dest_dirs is false.
      destination = "#{telegraf_config_directory}/inputs_influxdb.conf"

      # This options tells Consul Template to create the parent directories of the
      # destination path if they do not exist. The default value is true.
      create_dest_dirs = false

      # This is the optional command to run when the template is rendered. The
      # command will only run if the resulting template changes. The command must
      # return within 30s (configurable), and it must have a successful exit code.
      # Consul Template is not a replacement for a process monitor or init system.
      command = "systemctl reload #{telegraf_service}"

      # This is the maximum amount of time to wait for the optional command to
      # return. Default is 30s.
      command_timeout = "15s"

      # Exit with an error when accessing a struct or map field/key that does not
      # exist. The default behavior will print "<no value>" when accessing a field
      # that does not exist. It is highly recommended you set this to "true" when
      # retrieving secrets from Vault.
      error_on_missing_key = false

      # This is the permission to render the file. If this option is left
      # unspecified, Consul Template will attempt to match the permissions of the
      # file that already exists at the destination path. If no file exists at that
      # path, the permissions are 0644.
      perms = 0755

      # This option backs up the previously rendered template at the destination
      # path before writing a new one. It keeps exactly one backup. This option is
      # useful for preventing accidental changes to the data without having a
      # rollback strategy.
      backup = true

      # These are the delimiters to use in the template. The default is "{{" and
      # "}}", but for some templates, it may be easier to use a different delimiter
      # that does not conflict with the output file itself.
      left_delimiter  = "{{"
      right_delimiter = "}}"

      # This is the `minimum(:maximum)` to wait before rendering a new template to
      # disk and triggering a command, separated by a colon (`:`). If the optional
      # maximum value is omitted, it is assumed to be 4x the required minimum value.
      # This is a numeric time with a unit suffix ("5s"). There is no default value.
      # The wait value for a template takes precedence over any globally-configured
      # wait.
      wait {
        min = "2s"
        max = "10s"
      }
    }
  HCL
  mode '755'
end

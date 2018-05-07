Describe 'The influxdb application' {
    Context 'is installed' {
        It 'with binaries in /usr/bin/influxd' {
            '/usr/bin/influxd' | Should Exist
        }

        It 'with default configuration in /etc/influxdb/influxdb.conf' {
            '/etc/influxdb/influxdb.conf' | Should Exist
        }
    }

    Context 'has been daemonized' {
        $serviceConfigurationPath = '/lib/systemd/system/influxdb.service'
        if (-not (Test-Path $serviceConfigurationPath))
        {
            It 'has a systemd configuration' {
               $false | Should Be $true
            }
        }

        $expectedContent = @'
# If you modify this, please also make sure to edit init.sh

[Unit]
Description=InfluxDB is an open-source, distributed, time series database
Documentation=https://docs.influxdata.com/influxdb/
After=network-online.target

[Service]
User=influxdb
Group=influxdb
LimitNOFILE=65536
EnvironmentFile=-/etc/default/influxdb
ExecStart=/usr/bin/influxd -config /etc/influxdb/influxdb.conf $INFLUXD_OPTS
KillMode=control-group
Restart=on-failure

[Install]
WantedBy=multi-user.target
Alias=influxd.service

'@
        $serviceFileContent = Get-Content $serviceConfigurationPath | Out-String
        $systemctlOutput = & systemctl status influxdb
        It 'with a systemd service' {
            $serviceFileContent | Should Be ($expectedContent -replace "`r", "")

            $systemctlOutput | Should Not Be $null
            $systemctlOutput.GetType().FullName | Should Be 'System.Object[]'
            $systemctlOutput.Length | Should BeGreaterThan 3
            $systemctlOutput[0] | Should Match 'influxdb.service - InfluxDB is an open-source, distributed, time series database'
        }

        It 'that is enabled' {
            $systemctlOutput[1] | Should Match 'Loaded:\sloaded\s\(.*;\senabled;.*\)'

        }

        It 'and is running' {
            $systemctlOutput[2] | Should Match 'Active:\sactive\s\(running\).*'
        }
    }

    Context 'can be contacted' {
        try
        {
            $response = Invoke-WebRequest -Uri "http://localhost:8086/ping" -Headers $headers -UseBasicParsing
        }
        catch
        {
            # Because powershell sucks it throws if the response code isn't a 200 one ...
            $response = $_.Exception.Response
        }

        It 'responds to HTTP calls' {
            $response.StatusCode | Should Be 204
        }
    }
}

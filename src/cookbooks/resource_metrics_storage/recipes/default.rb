# frozen_string_literal: true

#
# Cookbook Name:: resource_metrics_storage
# Recipe:: default
#
# Copyright 2018, P. van der Velde
#

# Always make sure that apt is up to date
apt_update 'update' do
  action :update
end

#
# Include the local recipes
#

include_recipe 'resource_metrics_storage::firewall'

include_recipe 'resource_metrics_storage::meta'
include_recipe 'resource_metrics_storage::provisioning'

include_recipe 'resource_metrics_storage::influxdb'

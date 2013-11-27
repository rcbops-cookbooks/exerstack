#
# Cookbook Name:: exerstack
# Recipe:: default
#
# Copyright 2012-2013, Rackspace US, Inc.
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

# installs and configures the openstack cli exerciser, 'exerstack'

include_recipe "osops-utils"

platform_options = node["exerstack"]["platform"]

platform_options["packages"].each do |pkg|
  package pkg do
    action :install
  end
end

git "/opt/exerstack" do
  repository "https://github.com/rcbops/exerstack"
  action :sync
end

if Chef::Config[:solo]
  keystone = node["solo"]["keystone"]
  ks_service_endpoint = node["solo"]["ks_service_endpoint"]
else
  keystone = get_settings_by_role("keystone-setup", "keystone")
  ks_service_endpoint = get_access_endpoint("keystone-api", "keystone",
    "service-api")
end

keystone_admin_username = keystone['admin_user']
keystone_admin_password =
  keystone['users'][keystone_admin_username]['password']
keystone_admin_tenantname =
  keystone['users'][keystone_admin_username]['default_tenant']
keystone_service_url = ks_service_endpoint['uri']

unless rcb_safe_deref(node, "ha.swift-only")
  unless Chef::Config[:solo]
    ec2_public_endpoint = get_access_endpoint("nova-api-ec2", "nova",
      "ec2-public")["uri"]
    ec2_creds = get_settings_by_role("keystone-setup",
      "credentials")["EC2"][keystone["admin_user"]]
  end
end

# This is ghetto.. but i am trying to get nova allinone working
unless Chef::Config[:solo]
  swift = get_settings_by_role("swift-proxy-server", "swift")
end
if swift.nil?
  swift_authmode = "swauth"
else
  swift_authmode = swift["authmode"]
end

template "/opt/exerstack/localrc" do
  source "localrc.erb"
  owner "root"
  group "root"
  mode "0644"
  vars = {
    "keystone_admin_username" => keystone_admin_username,
    "keystone_admin_password" => keystone_admin_password,
    "keystone_admin_tenantname" => keystone_admin_tenantname,
    "keystone_service_url" => keystone_service_url,
    "keystone_region_name" => node["osops"]["region"],
    "keystone_admin_password" => keystone_admin_password,
    "swift_authtype" => swift_authmode
  }
  if ec2_public_endpoint
    vars["ec2_url"] = ec2_public_endpoint
  end
  unless ec2_creds.nil?
    vars["ec2_access"] = ec2_creds["access"]
    vars["ec2_secret"] = ec2_creds["secret"]
  end
  variables(vars)
end

# execute "run exerstack" do
#   command "./exercises.sh"
#   cwd "/opt/exerstack"
#   user "root"
#   action :nothing
# end

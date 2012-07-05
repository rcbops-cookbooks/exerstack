

case node["platform"]
when "ubuntu","debian"
  %w{git bc euca2ools netcat glance-client}.each do |pkg|
    package pkg do
      action :install
    end
  end
when "redhat","centos","fedora","scientific","amazon"
  %w{git bc euca2ools nc openstack-glance openstack-keystone}.each do |pkg|
    package pkg do
      action :install
    end
  end
end

execute "git clone https://github.com/rcbops/exerstack" do
  command "git clone https://github.com/rcbops/exerstack"
  cwd "/opt"
  user "root"
  not_if do File.exists?("/opt/exerstack") end
end

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
  keystone = search(:node, "roles:keystone AND chef_environment:#{node.chef_environment}")
  if keystone.length > 0
    keystone_admin_username = keystone[0]['keystone']['admin_user']
    keystone_admin_password = keystone[0]['keystone']['users'][keystone_admin_username]['password']
    keystone_admin_tenantname = keystone[0]['keystone']['users'][keystone_admin_username]['default_tenant']
    keystone_internal_url = keystone[0]['keystone']['internalURL']
    keystone_admin_url = keystone[0]['keystone']['adminURL']
    keystone_admin_token = keystone[0]['keystone']['admin_token']

    # determine if we have a nova-api-ec2 endpoint - if we do not then set the variables to a dummy
    # value so the template will process correctly.
    ec2api = search(:node, "roles:nova-api-ec2 AND chef_environment:#{node.chef_environment}")
    if ec2api.length > 0
      ec2_access = keystone[0]["credentials"]["EC2"]["admin"]["access"]
      ec2_secret = keystone[0]["credentials"]["EC2"]["admin"]["secret"]
    else
      ec2_access = "undefined"
      ec2_secret = "undefined"
    end
  else
    keystone_admin_username = node['keystone']['admin_user']
    keystone_admin_password = node['keystone']['users'][keystone_admin_username]['password']
    keystone_admin_tenantname = node['keystone']['users'][keystone_admin_username]['default_tenant']
    keystone_internal_url = node['keystone']['internalURL']
    keystone_admin_url = node['keystone']['adminURL']
    keystone_admin_token = node['keystone']['admin_token']
    ec2_access = node["credentials"]["EC2"]["admin"]["access"]
    ec2_secret = node["credentials"]["EC2"]["admin"]["secret"]
  end
end

ec2_public_endpoint = get_bind_endpoint("nova", "ec2-public")

# This is ghetto.. but i am trying to get nova allinone working
swift = get_settings_by_role("swift-proxy-server", "swift")
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
  variables(
    "keystone_admin_username" => keystone_admin_username,
    "keystone_admin_password" => keystone_admin_password,
    "keystone_admin_tenantname" => keystone_admin_tenantname,
    "keystone_internal_url" => keystone_internal_url,
    "keystone_admin_url" => keystone_admin_url,
    "keystone_region_name" => "RegionOne",
    "keystone_admin_token" => keystone_admin_token,
    "ec2_url" => ec2_public_endpoint["uri"],
    "ec2_access" => ec2_access,
    "ec2_secret" => ec2_secret,
    "swift_authtype" => swift_authmode
  )
end

# execute "run exerstack" do
#   command "./exercises.sh"
#   cwd "/opt/exerstack"
#   user "root"
#   action :nothing
# end


case platform
when "ubuntu", "debian"
  default["exerstack"]["platform"]["essex-final"] = {
    "packages" => [ "git", "bc", "euca2ools", "netcat", "glance-client" ]
  }
  default["exerstack"]["platform"]["folsom"] = {
    "packages" => [ "git", "bc", "euca2ools", "netcat", "python-glanceclient", "python-swiftclient", "lvm2" ]
  }
when "redhat", "centos", "fedora", "scientific", "amazon"
  default["exerstack"]["platform"]["essex-final"] = {
    "packages" => [ "git", "bc", "euca2ools", "nc", "openstack-glance", "openstack-keystone" ]
  }
  default["exerstack"]["platform"]["folsom"] = {
    "packages" => [ "git", "bc", "euca2ools", "nc", "openstack-glance", "openstack-keystone", "python-swiftclient", "lvm2" ]
  }
end

case platform
when "ubuntu", "debian"
  default["exerstack"]["platform"]["essex-final"] = {
    "packages" => [ "git", "bc", "euca2ools", "netcat", "glance-client" ]
  }
  default["exerstack"]["platform"]["folsom"] = {
    "packages" => [ "git", "bc", "euca2ools", "netcat", "mysql-client",
      "python-cinderclient", "python-glanceclient", "python-keystoneclient",
      "python-novaclient", "python-swiftclient", "lvm2" ]
  }
when "redhat", "centos", "fedora", "scientific", "amazon"
  default["exerstack"]["platform"]["essex-final"] = {
    "packages" => [ "git", "bc", "euca2ools", "nc", "openstack-glance",
      "openstack-keystone" ]
  }
  default["exerstack"]["platform"]["folsom"] = {
    "packages" => [ "git", "bc", "euca2ools", "nc", "mysql",
      "python-cinderclient", "python-glanceclient", "python-keystoneclient",
      "python-novaclient", "python-swiftclient", "lvm2" ]
  }
end

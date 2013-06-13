case platform
when "ubuntu", "debian"
  default["exerstack"]["platform"] = {
    "packages" => ["git", "bc", "euca2ools", "netcat", "mysql-client",
      "python-cinderclient", "python-glanceclient", "python-keystoneclient",
      "python-novaclient", "python-swiftclient", "lvm2",
      "python-ceilometerclient"]
  }
when "redhat", "centos", "fedora", "scientific", "amazon"
  default["exerstack"]["platform"] = {
    "packages" => ["git", "bc", "euca2ools", "nc", "mysql",
      "python-cinderclient", "python-glanceclient", "python-keystoneclient",
      "python-novaclient", "python-swiftclient", "lvm2",
      "python-ceilometerclient"]
  }
end

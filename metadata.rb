maintainer        "Rackspace Hosting, Inc."
license           "Apache 2.0"
description       "exerstack module"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

%w{ ubuntu fedora }.each do |os|
  supports os
end

%w{osops-utils keystone}.each do |dep|
  depends dep
end

name             'exerstack_test'
maintainer       'Rackspace US. Inc.'
license          'All rights reserved'
description      'Installs/Configures exerstack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ osops-utils sysctl }.each do |dep|
  depends dep
end

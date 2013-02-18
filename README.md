Description
===========

Installs and configures the OpenStack CLI exerciser, 'exerstack'

https://github.com/rcbops/exerstack

Requirements
============

Chef 0.10.0 or higher required (for Chef environment use)

Platform
--------

* CentOS >= 6.3
* Ubuntu >= 12.04

Cookbooks
---------

The following cookbooks are dependencies:

* osops-utils

Recipes
=======

default
-------

The default recipe installs and configures exerstack to /opt/exerstack

Templates
=========

* `localrc.erb` - Config containing OpenStack environment-specific environment variables

License and Author
==================

Author:: Justin Shepherd (<justin.shepherd@rackspace.com>)  
Author:: Jason Cannavale (<jason.cannavale@rackspace.com>)  
Author:: Ron Pedde (<ron.pedde@rackspace.com>)  
Author:: Joseph Breu (<joseph.breu@rackspace.com>)  
Author:: William Kelly (<william.kelly@RACKSPACE.COM>)  
Author:: Darren Birkett (<Darren.Birkett@rackspace.co.uk>)  
Author:: Evan Callicoat (<evan.callicoat@RACKSPACE.COM>)  
Author:: Matt Thompson (<matt.thompson@rackspace.co.uk>)  

Copyright 2012, Rackspace US, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

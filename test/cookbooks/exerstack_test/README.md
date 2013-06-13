exerstack Cookbook
==================
Cookbook for testing the exerstack cookbook, which deploys the exerstack
tests for openstack. 

Requirements
------------
Requirements are listed in the exerstack Berksfile, metadata file and 
gemfile.

Attributes
----------
This cookbook requires no attributes, but it supplies some attributes to the
exerstack cookbook, see .kitchen.yml in the root of the exerstack cookbook
for details.

Usage
-----
#### exerstack::default
From the exerstack cookbook, run bundle install; kitchen test all
Also read TESTING.md in the exerstack cookbook.

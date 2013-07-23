#
# Cookbook Name:: exerstack_test
# Recipe:: server
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

require_relative "./support/helpers"

describe_recipe "exerstack_test::default" do
  include ExerstackTestHelpers

  describe "creates the required files" do
    it "creates a exersetack localrc file" do
      file("/opt/exerstack/localrc").must_exist
    end
    it "clones the exerstack git repo" do
      file("/opt/exerstack/.gitignore").must_exist
    end
  end

  describe "installs the required packages" do
    it "installs the required packcages" do
      %w(git bc lvm2).each do |package_name|
        package(package_name).must_be_installed
      end
    end
  end

end

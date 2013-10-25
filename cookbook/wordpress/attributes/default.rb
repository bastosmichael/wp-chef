#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Cookbook Name:: wordpress
# Attributes:: wordpress
#
# Copyright 2009-2010, Opscode, Inc.
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

# General settings
default['wordpress']['version'] = "latest"
default['wordpress']['checksum'] = ""
default['wordpress']['dir'] = "/var/www"
default['wordpress']['db']['database'] = node['mysql']['database']
default['wordpress']['db']['user'] = node['mysql']['dbuser']
default['wordpress']['db']['host'] = node['mysql']['dbhost']
default['wordpress']['server_aliases'] = [node['fqdn']]

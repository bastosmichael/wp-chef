#
# Cookbook Name:: wordpress
# Recipe:: default
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

include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"

# Make sure the mysql gem is installed. This looks like it will change with 
# the release of 0.10.10 and the inclusion of the new chef_gem. 
# code curtesy @hectcastro
# http://tickets.opscode.com/browse/COOK-1009
gem_package "mysql" do
  action :install
end

if node.has_key?("ec2")
  server_fqdn = node['ec2']['public_hostname']
else
  server_fqdn = "localhost:8000"
end

node.set_unless['wordpress']['db']['password'] = node['mysql']['server_root_password']
node.set_unless['wordpress']['keys']['auth'] = secure_password
node.set_unless['wordpress']['keys']['secure_auth'] = secure_password
node.set_unless['wordpress']['keys']['logged_in'] = secure_password
node.set_unless['wordpress']['keys']['nonce'] = secure_password


if node['wordpress']['version'] == 'latest'
  # WordPress.org does not provide a sha256 checksum, so we'll use the sha1 they do provide
  require 'digest/sha1'
  require 'open-uri'
  local_file = "#{Chef::Config[:file_cache_path]}/wordpress-latest.tar.gz"
  latest_sha1 = open('http://wordpress.org/latest.tar.gz.sha1') {|f| f.read }
  unless File.exists?(local_file) && ( Digest::SHA1.hexdigest(File.read(local_file)) == latest_sha1 )
    remote_file "#{Chef::Config[:file_cache_path]}/wordpress-latest.tar.gz" do
      source "http://wordpress.org/latest.tar.gz"
      mode "0644"
    end
  end
else
  remote_file "#{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.tar.gz" do
    source "http://wordpress.org/wordpress-#{node['wordpress']['version']}.tar.gz"
    mode "0644"
  end
end

directory "#{node['wordpress']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
  notifies :run, "execute[make-www-data-owner]", :immediately
end

execute "make-www-data-owner" do
  command "sudo chown -R www-data:www-data #{node['wordpress']['dir']}"
  only_if { Etc.getpwuid(File.stat("#{node['wordpress']['dir']}").uid).name != "www-data" }
end

execute "untar-wordpress" do
  cwd node['wordpress']['dir']
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.tar.gz"
  creates "#{node['wordpress']['dir']}/wp-settings.php"
end

execute "mysql-install-wp-privileges" do
  command "/usr/bin/mysql -u root -p\"#{node['mysql']['server_root_password']}\" < #{node['mysql']['conf_dir']}/wp-grants.sql"
  action :nothing
end

template "#{node['mysql']['conf_dir']}/wp-grants.sql" do
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :user     => node['wordpress']['db']['user'],
    :password => node['wordpress']['db']['password'],
    :database => node['wordpress']['db']['database']
  )
  notifies :run, "execute[mysql-install-wp-privileges]", :immediately
end

execute "create #{node['wordpress']['db']['database']} database" do
  command "/usr/bin/mysqladmin -u root -p\"#{node['mysql']['server_root_password']}\" create #{node['wordpress']['db']['database']}"
  not_if do
    # Make sure gem is detected if it was just installed earlier in this recipe
    require 'rubygems'
    Gem.clear_paths
    require 'mysql'
    m = Mysql.new("localhost", "root", node['mysql']['server_root_password'])
    m.list_dbs.include?(node['wordpress']['db']['database'])
  end
  notifies :create, "ruby_block[save node data]", :immediately unless Chef::Config[:solo]
end

# save node data after writing the MYSQL root password, so that a failed chef-client run that gets this far doesn't cause an unknown password to get applied to the box without being saved in the node data.
unless Chef::Config[:solo]
  ruby_block "save node data" do
    block do
      node.save
    end
    action :create
  end
end

log "Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation" do
  action :nothing
end

template "#{node['wordpress']['dir']}/wp-config.php" do
  source "wp-config.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :host            => node['wordpress']['db']['host'],
    :database        => node['wordpress']['db']['database'],
    :user            => node['wordpress']['db']['user'],
    :password        => node['wordpress']['db']['password'],
    :auth_key        => node['wordpress']['keys']['auth'],
    :secure_auth_key => node['wordpress']['keys']['secure_auth'],
    :logged_in_key   => node['wordpress']['keys']['logged_in'],
    :nonce_key       => node['wordpress']['keys']['nonce']
  )
  notifies :write, "log[Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation]"
end

# apache_site "000-default" do
#   enable false
# end

# web_app "wordpress" do
#   template "wordpress.conf.erb"
#   docroot "#{node['wordpress']['dir']}"
#   server_name server_fqdn
#   server_aliases node['wordpress']['server_aliases']
# end

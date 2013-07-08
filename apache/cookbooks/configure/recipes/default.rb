# Cookbook Name:: configure
# Recipe:: default
#
# Copyright 2013, Version2beta LLC
#
# execute 'DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade'

[ "build-essential", "apache2", "mysql::server",
  "database", "wordpress", "vim"].each do |r|
  include_recipe r
end

directory "/home/vagrant/bin" do
  owner "vagrant"
  group "vagrant"
  mode 00755
  recursive true
end

remote_file "/home/vagrant/bin/vcprompt" do
  source "https://raw.github.com/djl/vcprompt/master/bin/vcprompt"
  action :create_if_missing
  owner "vagrant"
  group "vagrant"
  mode 00755
end

cookbook_file "/home/vagrant/.profile" do
  source "bash_profile"
  owner "vagrant"
  group "vagrant"
  mode 00755
end

cookbook_file "/home/vagrant/.vimrc" do
  source "vimrc"
  owner "vagrant"
  group "vagrant"
  mode 00755
end

directory "/var/www/" do
  owner "www-data"
  group "www-data"
  owner 00777
  recursive true
end

link "/home/vagrant/blog" do
  to "/var/www/wordpress"
end


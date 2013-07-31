#
# Author::  Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php-fpm
# Recipe:: default
#
# Copyright 2011, Opscode, Inc.
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

case node['platform']
when 'ubuntu'
  if node['platform_version'].to_f <= 10.04
    # Configure Brian's PPA
    # We'll install php5-fpm from the Brian's PPA backports
    apt_repository "brianmercer-php" do
      uri "http://ppa.launchpad.net/brianmercer/php5/ubuntu"
      distribution node['lsb']['codename']
      components ["main"]
      keyserver "keyserver.ubuntu.com"
      key "8D0DC64F"
      action :add
    end
    # FIXME: apt-get update didn't trigger in above
    execute "apt-get update"
  end
when 'debian'
  # Configure Dotdeb repos
  # TODO: move this to it's own 'dotdeb' cookbook?
  # http://www.dotdeb.org/instructions/
  if node.platform_version.to_f >= 5.0
    apt_repository "dotdeb" do
      uri "http://packages.dotdeb.org"
      distribution "stable"
      components ['all']
      key "http://www.dotdeb.org/dotdeb.gpg"
      action :add
    end
  else
    apt_repository "dotdeb" do
      uri "http://packages.dotdeb.org"
      distribution "oldstable"
      components ['all']
      key "http://www.dotdeb.org/dotdeb.gpg"
      action :add
    end
    apt_repository "dotdeb-php53" do
      uri "http://php53.dotdeb.org"
      distribution "oldstable"
      components ['all']
      key "http://www.dotdeb.org/dotdeb.gpg"
      action :add
    end
  end
when 'centos', 'redhat', 'fedora'
  # Configure IUS repo
  # http://rob.olmos.name/2010/08/centos-5-5-php-5-3-3-php-fpm-nginx-rpms/
  # TODO: verify this is the best repo
  yum_repository "ius" do
    url "http://dl.iuscommunity.org/pub/ius/stable/Redhat/5.5/$basearch"
    action :add
  end
end

pkgs = value_for_platform(
  %w{ centos redhat fedora } => {
    "default" => %w{ php53u-fpm and php53u-pecl-apc }
  },
  %w{ debian ubuntu } => {
    "default" => %w{ php5-cgi php5-fpm }
  },
  "default" => %w{ php5-cgi php5-fpm }
)

unless platform?(%w{ centos redhat fedora })
  # TODO: look into the php53u-*/php53-* conflict
  require_recipe 'php::default'
end

pkgs.each do |pkg|
  package pkg do
    action :upgrade
  end
end

service "php5-fpm" do
  action [ :enable, :start ]
end

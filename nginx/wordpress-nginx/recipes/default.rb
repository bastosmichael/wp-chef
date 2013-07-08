#
# Cookbook Name:: wordpress-nginx
# Recipe:: default
#
template "#{node['nginx']['dir']}/wordpress.conf" do
  source   'wordpress-common.erb'
  owner    'root'
  group    'root'
  mode     00644
  notifies :reload, 'service[nginx]'
  variables(
    :php_fpm_socket => node['php-fpm']['pool']['www']['listen']
  )
end

template "#{node['nginx']['dir']}/sites-available/wordpress" do
  source   'wordpress-sites.erb'
  owner    'root'
  group    'root'
  mode     00644
  notifies :reload, 'service[nginx]'
  variables(
    :sites => node['wordpress_nginx']['sites']
  )
end

nginx_site 'wordpress' do
  enable true
end

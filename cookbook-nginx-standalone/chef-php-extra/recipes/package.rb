if node['platform_version'].to_f < 6.0
  centos_packages = %w{ php53 php53-devel php53-cli php-pear }
else
  centos_packages = %w{ php php-devel php-cli php-pear }
end

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => centos_packages
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-cgi php5 php5-dev php5-cli php-pear }
  },
  "default" => %w{ php5-cgi php5 php5-dev php5-cli php-pear }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :params => node['php']
  )
end

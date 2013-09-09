maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures php-fpm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.4"

depends "php"
depends "apt"
depends "yum"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end

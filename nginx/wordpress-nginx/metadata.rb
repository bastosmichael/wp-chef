name             'wordpress-nginx'
maintainer_email 'scott.walkinshaw@gmail.com'
license          'MIT'
description      'Installs/Configures wordpress-nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'nginx'
depends          'php-fpm'

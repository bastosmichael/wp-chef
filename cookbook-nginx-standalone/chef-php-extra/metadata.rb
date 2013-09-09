maintainer       "Alistair Stead"
maintainer_email "alistair.stead@inviqa.com"
license          "Apache 2.0"
description      "Installs/Configures additional PHP modules, PEAR and PECL packages"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "git"
depends "yum"
depends "apt"
depends "php"
depends "chef-php-extra"

%w{ ubuntu, debian, centos, redhat, fedora }.each do |os|
  supports os
end

recipe "chef-php-extra", "No default install"
recipe "chef-php-extra::development", "Install development tools"
recipe "chef-php-extra::module_dev", "Install additional module"
recipe "chef-php-extra::module_gd", "Install additional module"
recipe "chef-php-extra::module_imagick", "Install additional module"
recipe "chef-php-extra::module_mcrypt", "Install additional module"
recipe "chef-php-extra::module_soap", "Install additional module soap"
recipe "chef-php-extra::module_xml", "Install additional module xml"
recipe "chef-php-extra::pear", "Updates pear using pear"
recipe "chef-php-extra::PHP_CodeBrowser", "Install PHP_CodeBrowser"
recipe "chef-php-extra::PHP_CodeSniffer", "Install PHP_CodeSniffer"
recipe "chef-php-extra::PHP_Depend", "Install PHP_Depend"
recipe "chef-php-extra::PHP_PMD", "Install PHP_PMD"
recipe "chef-php-extra::phpcpd", "Install phpcpd"
recipe "chef-php-extra::PhpDocumentor", "Install PhpDocumentor"
recipe "chef-php-extra::phploc", "Install phploc"
recipe "chef-php-extra::PHPUnit", "Install PHPUnit"
recipe "chef-php-extra::vfsStream", "Install vfsStream with PEAR"
recipe "chef-php-extra::xdebug", "Install xdebug"
recipe "chef-php-extra::PHPUnit", "Install Zend Framework with PEAR"

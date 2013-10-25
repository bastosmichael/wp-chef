maintainer       "Barry Steinglass"
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures WordPress"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe "WordPress", "Installs and configures WordPress LAMP stack on a single system"

%w{ php openssl }.each do |cb|
  depends cb
end

depends "apache2", ">= 0.99.4"
depends "mysql", ">= 1.0.5"

%w{ debian ubuntu }.each do |os|
  supports os
end

attribute "WordPress/version",
  :display_name => "WordPress download version",
  :description => "Version of WordPress to download from the WordPress site or 'latest' for the current release.",
  :default => "latest"

attribute "WordPress/checksum",
  :display_name => "WordPress tarball checksum",
  :description => "Checksum of the tarball for the version specified.",
  :default => ""

attribute "WordPress/dir",
  :display_name => "WordPress installation directory",
  :description => "Location to place WordPress files.",
  :default => "/var/www/wordpress"

attribute "WordPress/db/database",
  :display_name => "WordPress MySQL database",
  :description => "WordPress will use this MySQL database to store its data.",
  :default => "wordpressdb"

attribute "WordPress/db/user",
  :display_name => "WordPress MySQL user",
  :description => "WordPress will connect to MySQL using this user.",
  :default => "wordpressuser"

attribute "WordPress/db/password",
  :display_name => "WordPress MySQL password",
  :description => "Password for the WordPress MySQL user.",
  :default => "randomly generated"

attribute "WordPress/keys/auth",
  :display_name => "WordPress auth key",
  :description => "WordPress auth key.",
  :default => "randomly generated"

attribute "WordPress/keys/secure_auth",
  :display_name => "WordPress secure auth key",
  :description => "WordPress secure auth key.",
  :default => "randomly generated"

attribute "WordPress/keys/logged_in",
  :display_name => "WordPress logged-in key",
  :description => "WordPress logged-in key.",
  :default => "randomly generated"

attribute "WordPress/keys/nonce",
  :display_name => "WordPress nonce key",
  :description => "WordPress nonce key.",
  :default => "randomly generated"

attribute "WordPress/server_aliases",
  :display_name => "WordPress Server Aliases",
  :description => "WordPress Server Aliases",
  :default => "FQDN"

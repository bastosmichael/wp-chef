default['wordpress_nginx']['fastcgi_read_timeout'] = '3600s'
default['wordpress_nginx']['static_file_expiry'] = '24h'
default['wordpress_nginx']['sites'] = {
  'default' => {
    'hosts'    => 'localhost',
    'root'     => '/srv/www/default',
    'rewrites' => nil
  }
}

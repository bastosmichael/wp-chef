include_recipe "chef-php-extra::pear"

zf = chef_php_extra_pear_channel "pear.zfcampus.org" do
  action :discover
end

chef_php_extra_pear "zf" do
  preferred_state "stable"
  channel zf.channel_name
  action :install
end

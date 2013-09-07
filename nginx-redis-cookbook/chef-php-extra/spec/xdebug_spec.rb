require 'chefspec'

describe 'chef-php-extra::xdebug' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::xdebug' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

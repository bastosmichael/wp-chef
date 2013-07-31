require 'chefspec'

describe 'chef-php-extra::pear' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::pear' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

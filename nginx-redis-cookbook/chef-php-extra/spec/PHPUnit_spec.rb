require 'chefspec'

describe 'chef-php-extra::PHPUnit' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::PHPUnit' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

require 'chefspec'

describe 'chef-php-extra::module_dev' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::module_dev' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

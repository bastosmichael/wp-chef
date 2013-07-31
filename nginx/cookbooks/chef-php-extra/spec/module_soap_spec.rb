require 'chefspec'

describe 'chef-php-extra::module_soap' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::module_soap' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

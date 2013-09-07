require 'chefspec'

describe 'chef-php-extra::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

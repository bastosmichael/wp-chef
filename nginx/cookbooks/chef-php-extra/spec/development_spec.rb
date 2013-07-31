require 'chefspec'

describe 'chef-php-extra::development' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::development' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

require 'chefspec'

describe 'chef-php-extra::package' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::package' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

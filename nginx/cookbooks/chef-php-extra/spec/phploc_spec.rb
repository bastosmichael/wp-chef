require 'chefspec'

describe 'chef-php-extra::phploc' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::phploc' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

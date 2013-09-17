require 'chefspec'

describe 'chef-php-extra::PHP_Depend' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::PHP_Depend' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

require 'chefspec'

describe 'chef-php-extra::phpcpd' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::phpcpd' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

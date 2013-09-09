require 'chefspec'

describe 'chef-php-extra::PhpDocumentor' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::PhpDocumentor' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

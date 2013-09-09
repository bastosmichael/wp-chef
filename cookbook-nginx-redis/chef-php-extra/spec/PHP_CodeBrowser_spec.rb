require 'chefspec'

describe 'chef-php-extra::PHP_CodeBrowser' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::PHP_CodeBrowser' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

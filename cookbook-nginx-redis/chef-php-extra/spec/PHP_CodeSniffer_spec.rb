require 'chefspec'

describe 'chef-php-extra::PHP_CodeSniffer' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::PHP_CodeSniffer' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

require 'chefspec'

describe 'chef-php-extra::predis' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::predis' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end

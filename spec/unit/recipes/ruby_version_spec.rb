require 'spec_helper'

describe 'resource_fixtures::ruby_version' do 
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: 'ruby_version').converge(described_recipe)
  end

  context 'when the version is not already instealled' do 
    it 'installs the given ruby version' do 
      allow_any_instance_of(Chef::Resource::Execute).to receive(:`).and_return('')
      expect(chef_run).to run_execute('install 2.2.2').with(command: '/usr/local/bin/rbenv install 2.2.2')
    end
  end
  
  context 'when the version is already instealled' do 
    it 'is blocked by the guard clause' do 
      allow_any_instance_of(Chef::Resource::Execute).to receive(:`).and_return("system\n2.2.2\n2.3.0")
      expect(chef_run).not_to run_execute('install 2.2.2')
    end
  end
end

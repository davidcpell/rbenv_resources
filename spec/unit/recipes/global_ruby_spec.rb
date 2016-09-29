require 'spec_helper'

describe 'resource_fixtures::global_ruby' do 
  let(:chef_run) do 
    ChefSpec::SoloRunner.new(step_into: 'global_ruby').converge(described_recipe)
  end

  it 'sets the global ruby version' do 
    expect(chef_run).to run_execute('set global ruby').with(command: '/usr/local/bin/rbenv global 2.2.2')
  end
end

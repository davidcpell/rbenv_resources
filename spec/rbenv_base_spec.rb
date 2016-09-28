require 'spec_helper'

describe 'resource_fixtures::rbenv_base' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: 'rbenv_base').converge(described_recipe)
  end

  context 'when a prefix is specified but everything else is default' do
    it 'clones the rbenv repo' do
      prefix = '/test_prefix'
      opts   = { destination: prefix, action: [:sync], revision: 'master', repository: 'https://github.com/rbenv/rbenv' }

      expect(chef_run).to sync_git('/test_prefix').with(opts)
    end
  end
end

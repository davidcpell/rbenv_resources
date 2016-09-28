require 'spec_helper'

describe 'resource_fixtures::rbenv_base' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: 'rbenv_base').converge(described_recipe)
  end

  context 'when a prefix is specified but everything else is default' do
    let(:prefix) { '/test_prefix' }
    let(:basic_git_opts) { { action: [:sync], revision: 'master' } }

    it 'clones the rbenv repo' do
      rbenv_opts = basic_git_opts.merge(destination: prefix, repository: 'https://github.com/rbenv/rbenv')

      expect(chef_run).to sync_git('/test_prefix').with(rbenv_opts)
    end

    it 'installs ruby-build' do
      expect(chef_run).to create_directory('/test_prefix/.rbenv/plugins')
      expect(chef_run).to sync_git('/test_prefix/.rbenv/plugins/ruby-build').with(basic_git_opts)
    end
  end
end

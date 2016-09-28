require 'spec_helper'

describe 'resource_fixtures::rbenv_base' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: 'rbenv_base').converge(described_recipe)
  end

  context 'when a prefix is specified but everything else is default' do
    let(:target) { '/opt/.rbenv' }
    let(:basic_git_opts) { { action: [:sync], revision: 'master' } }

    it 'clones the rbenv repo' do
      rbenv_opts = basic_git_opts.merge(destination: target, repository: 'https://github.com/rbenv/rbenv')

      expect(chef_run).to sync_git('/opt/.rbenv').with(rbenv_opts)
    end

    it 'creates a symlink for the rbenv binary' do 
      expect(chef_run).to create_link('/usr/local/bin/rbenv').with(to: '/opt/.rbenv/bin/rbenv')
    end

    it 'installs ruby-build' do
      expect(chef_run).to create_directory('/opt/.rbenv/plugins')
      expect(chef_run).to sync_git('/opt/.rbenv/plugins/ruby-build').with(basic_git_opts)
    end
  end
end

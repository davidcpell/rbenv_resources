resource_name :rbenv_base

property :prefix, String, name_property: true, default: '/opt'
property :git_revision, String, default: 'master'

default_action :install

action :install do
  git prefix do
    action      :sync
    destination prefix
    repository  'https://github.com/rbenv/rbenv'
    revision    git_revision
  end
end

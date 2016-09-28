resource_name :rbenv_base

property :git_revision, String, default: 'master'
property :prefix, String, name_property: true
property :ruby_build, [TrueClass, FalseClass], default: true

default_action :install

action :install do
  git prefix do
    action      :sync
    destination prefix
    repository  'https://github.com/rbenv/rbenv'
    revision    git_revision
  end

  if ruby_build == true
    plugins_dir = ::File.join(prefix, '.rbenv', 'plugins')

    directory plugins_dir

    git ::File.join(plugins_dir, 'ruby-build') do 
      action     :sync
      repository 'https://github.com/rbenv/ruby-build.git'
      revision   'master'
    end
  end
end

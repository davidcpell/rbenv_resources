resource_name :system_rbenv

property :prefix, String, name_property: true
property :ruby_versions, [Array], required: true
property :global_ruby, String, required: true

default_action :install

action :install do
  rbenv_root  = ::File.join(prefix, 'rbenv')
  rbenv_plugs = ::File.join(rbenv_root, 'plugins')
  rbenv_bin   = ::File.join(rbenv_root, 'bin')
  ENV['RBENV_ROOT'] = rbenv_root
  ENV['PATH'] = "#{rbenv_bin}:#{ENV['PATH']}"

  install_packages

  git rbenv_root do
    action      :sync
    repository  'https://github.com/rbenv/rbenv'
    revision    'master'
  end

  directory rbenv_plugs

  git "#{rbenv_plugs}/ruby-build" do
    action     :sync
    repository 'https://github.com/rbenv/ruby-build.git'
    revision   'master'
  end

  template '/etc/profile.d/rbenv.sh' do 
    cookbook  'rbenv_resources'
    mode      '0755'
    source    'rbenv.sh.erb'
    variables 'rbenv_root' => rbenv_root

    notifies :run, 'bash[initialize rbenv]', :immediately
  end

  bash 'initialize rbenv' do 
    action :nothing
    code   'eval "$(rbenv init -)"'
  end

  bash "install ruby #{ruby_versions.first}" do 
    code   "#{rbenv_bin}/rbenv install #{ruby_versions.first}"
    not_if "#{rbenv_bin}/rbenv versions".include?(ruby_versions.first)
  end

  bash "set global ruby to #{global_ruby}" do 
    code "#{rbenv_bin}/rbenv global #{global_ruby}"
  end
end

resource_name :system_rbenv

property :prefix, String, name_property: true
property :rbenv_users, Array, required: true
property :ruby_versions, Array, required: true
property :global_ruby, String, required: true

default_action :install

action :install do
  rbenv_root  = ::File.join(prefix, 'rbenv')
  rbenv_plugs = ::File.join(rbenv_root, 'plugins')
  rbenv_bin   = ::File.join(rbenv_root, 'bin')
  rbenv_vers  = ::File.join(rbenv_root, 'versions')
  rbenv_shims = ::File.join(rbenv_root, 'shims')
  ENV['RBENV_ROOT'] = rbenv_root
  ENV['PATH'] = "#{rbenv_bin}:#{ENV['PATH']}"

  install_packages

  group 'rbenv' do 
    members rbenv_users
  end

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

  ruby_block 'append init script' do 
    block do 
      ::File.open(init_file, 'a') do |f|
        f.puts <<-EOF.gsub(/^\s+/, '')
        \n
        export RBENV_ROOT=#{rbenv_root}
        export PATH="#{rbenv_bin}:#{rbenv_shims}:$PATH"
        eval "$(rbenv init -)"
        EOF
      end
    end
  end

  bash 'initialize rbenv' do 
    action :nothing
    code   'eval "$(rbenv init -)"'
  end

  set_rbenv_permissions
end

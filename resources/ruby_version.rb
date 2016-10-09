resource_name :ruby_version

property :version, String, name_property: true

default_action :install

action :install do
  execute "rbenv install #{version}" do
    not_if do 
      shell_out('rbenv versions').stdout.include?(version)
    end
  end

  set_rbenv_permissions
end

action :uninstall do
  execute "rbenv uninstall -f #{version}" do
    only_if do 
      shell_out('rbenv versions').stdout.include?(version)
    end
  end
end

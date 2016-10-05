resource_name :global_ruby

property :version, String, name_property: true

default_action :set

action :set do 
  version_file = ::File.join(ENV['RBENV_ROOT'], 'version')

  bash "set global ruby to #{version}" do 
    code "rbenv global #{version}"
  end

  file version_file do 
    mode  '0775'
    group 'rbenv'
  end
end

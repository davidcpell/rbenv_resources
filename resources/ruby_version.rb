resource_name :ruby_version

property :version, String, required: true, name_property: true

default_action :install

action :install do 
  execute "install #{version}" do 
    command rbenv_exec("install #{version}")

    not_if do 
      `#{rbenv_exec('versions')}` =~ /#{version}/
    end
  end
end

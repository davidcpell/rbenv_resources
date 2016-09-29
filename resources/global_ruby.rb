resource_name :global_ruby

property :version, String, required: true, name_property: true

default_action :set

action :set do 
  execute 'set global ruby' do 
    command rbenv_exec("global #{version}")
  end
end

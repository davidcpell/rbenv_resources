def init_file
  case node['platform_family'] 
  when 'rhel'
    '/etc/bashrc'
  when 'debian'
    '/etc/bash.bashrc'
  end
end

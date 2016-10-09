def install_packages
  if node['platform_family'] == 'rhel'
    packages = %w(gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel)
    package packages
  end
end

def set_rbenv_permissions
  bash 'set permissions on rbenv paths' do 
    code <<-EOF
    chmod -R 775 #{ENV['RBENV_ROOT']}
    chgrp -R rbenv #{ENV['RBENV_ROOT']}
    EOF
  end
end

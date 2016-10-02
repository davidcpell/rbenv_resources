def install_packages
  if node['platform_family'] == 'rhel'
    packages = %w(gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel)
    package packages
  end
end

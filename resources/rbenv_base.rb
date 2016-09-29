resource_name :rbenv_base

property :git_revision, String, default: 'master'
property :prefix, String, name_property: true
property :ruby_build, [TrueClass, FalseClass], default: true

default_action :install

action :install do
  target    = ::File.join(prefix, '.rbenv')
  plugins   = ::File.join(target, 'plugins')
  rbenv_cmd = ::File.join(target, 'bin', 'rbenv')

  git target do
    action      :sync
    repository  'https://github.com/rbenv/rbenv'
    revision    git_revision
  end

  link '/usr/local/bin/rbenv' do 
    to "#{prefix}/.rbenv/bin/rbenv"
  end

  if ruby_build
    directory plugins

    git "#{plugins}/ruby-build" do
      action     :sync
      repository 'https://github.com/rbenv/ruby-build.git'
      revision   'master'
    end

    Dir["#{plugins}/ruby-build/bin/*"].each do |file|
      link "/usr/local/bin/#{Pathname.new(file).basename}" do 
        to file
      end
    end
  end
end

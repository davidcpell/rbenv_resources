# # encoding: utf-8

# Inspec test for recipe rbenv_resources::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe directory('/opt/.rbenv') do
  it { should exist }
end

describe directory('/opt/.rbenv/plugins/ruby-build') do
  it { should exist }
end

describe file('/usr/local/bin/rbenv') do 
  it { should be_symlink }
  its('link_path') { should eq '/opt/.rbenv/libexec/rbenv' }
end

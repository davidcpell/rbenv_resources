# # encoding: utf-8

# Inspec test for recipe rbenv_resources::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

ENV['RBENV_ROOT'] = '/opt/rbenv'
ENV['PATH'] = "/opt/rbenv/bin:#{ENV['PATH']}"

describe directory('/opt/rbenv/plugins/ruby-build') do
  it { should exist }
end

describe file('/etc/profile.d/rbenv.sh') do 
  its('content') { should match /export RBENV_ROOT=\/opt\/rbenv/ }
  its('content') { should match /export PATH="\/opt\/rbenv\/bin:\$PATH"/ }
  its('content') { should match /eval "\$\(rbenv init -\)"/ }
end

describe directory('/opt/rbenv/versions/2.2.2') do 
  it { should be_directory }
end

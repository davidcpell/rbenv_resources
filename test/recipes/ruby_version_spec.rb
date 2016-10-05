# Inspec test for recipe resource_fixtures::ruby_version

describe directory('/opt/rbenv/versions/2.2.2') do 
  it { should be_directory }
end

describe command('/opt/rbenv/bin/rbenv versions') do 
  its('stdout') { should include '2.2.2' }
end

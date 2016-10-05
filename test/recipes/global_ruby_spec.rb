# Inspec test for recipe resource_fixtures::ruby_version

describe directory('/opt/rbenv/version') do 
  it { should be_file }
  its('content') { should eq "2.2.2\n" }
end

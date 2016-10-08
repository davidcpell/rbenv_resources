describe command('bash -l -c "rbenv versions"') do 
  its('stdout') { should_not match /\d\.\d\.\d/ }
end

describe directory('/opt/rbenv/versions/2.2.2') do 
  it { should_not exist }
end

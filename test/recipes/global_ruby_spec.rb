describe command('rbenv global') do 
  its('stdout') { should eq "2.2.2\n" }
end

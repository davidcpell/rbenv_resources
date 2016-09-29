describe command('rbenv versions') do 
  its('stdout') { should include '2.2.2' }
end

require 'spec_helper'

describe package('mongodb') do
  it { should be_installed }
end

describe package('mongodb-tools') do
  it { should be_installed }
end

describe command('supervisorctl status mongodb') do
  its(:stdout){ should match(/RUNNING/) }
end

describe file('/etc/mongodb.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe command('supervisorctl status consul-template') do
  its(:stdout){ should match(/RUNNING/) }
end

describe file('/etc/mongodb.conf.ctmpl') do
  it { should be_file }
end

%w{pcre mongodb mongodb-tools}.each do |pkg|
  package pkg do
    action :install
  end
end

if node['mongodb']['supervisor']
  supervisor_service 'mongodb' do
    command '/usr/bin/mongod --config /etc/mongodb.conf'
    user 'mongodb'
    action [:enable, :start]
  end
else
  service 'mongodb' do
    supports status: true, start: true, stop: true, restart: true, reload: true
    action [:enable, :start]
  end
end

template '/etc/mongodb.conf' do
  mode '0644'
  source 'mongodb.conf.erb'
end

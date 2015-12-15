template '/etc/mongodb.conf.ctmpl' do
  mode '0644'
  source 'mongodb.conf.ctmpl.erb'
end

if node['mongodb']['supervisor']
  consul_template_config 'mongodb' do
    templates [{
      source: '/etc/mongodb.conf.ctmpl',
      destination: '/etc/mongodb.conf',
      command: 'supervisorctl restart mongodb'
    }]
    notifies :restart, 'supervisor_service[consul-template]', :delayed
  end
else
  consul_template_config 'mongodb' do
    templates [{
      source: '/etc/mongodb.conf.ctmpl',
      destination: '/etc/mongodb.conf',
      command: 'systemctl restart mongodb'
    }]
    notifies :restart, 'service[consul-template]', :delayed
  end
end

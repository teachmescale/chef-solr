include_recipe "solr::default"
include_recipe "supervisor::default"
include_recipe "logrotate::default"

service 'solr' do
  action [:disable, :stop]
end

solr_nodes = node['solr']['cloud']['shards'] + node['solr']['cloud']['replicas']
solr_nodes.each do |node|
  bash "create node config dir" do
    user "root"
    cwd "/etc/solr"
    code <<-EOH
        cp -r example $node
    EOH
    environment ({'node' => node})
  end
end

template '/etc/supervisor.d/solr.conf' do
  source 'supervisor.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  variables({
      :instances => solr_nodes
  })
end

template '/etc/logrotate.d/solr' do
  source 'logrotate.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

execute 'supervisorctl update' do
  user 'root'
end


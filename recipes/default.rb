#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2013, David Radcliffe
#

include_recipe 'java'
include_recipe "supervisor::default"
include_recipe "logrotate::default"

src_filename = ::File.basename(node['solr']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

remote_file src_filepath do
  source node['solr']['url']
  action :create_if_missing
end

bash 'unpack_solr' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{node['solr']['dir']}
    tar xzf #{src_filename} -C '/tmp'
    mv /tmp/solr-#{node['solr']['version']}/* #{node['solr']['dir']}
  EOH
  not_if { ::File.exists?(node['solr']['dir']) }
end

directory node['solr']['log_dir'] do
  owner 'root'
  group 'root'
  recursive true
  action :create
end

solr_nodes = node['solr']['cloud']['shards'] + node['solr']['cloud']['replicas']
solr_nodes.each do |node|
  bash "create #{node[:name]} config dir" do
    user "root"
    code <<-EOH
        cd /opt/solr
        cp -r example $node
        chmod 777 $node/solr-webapp
        rm $node/solr/solr.xml
    EOH
    environment ({'node' => node[:name]})
  end

  template "/opt/solr/#{node[:name]}/solr/solr.xml" do
    source 'solr.xml.erb'
    owner  'root'
    group  'root'
    mode   '0644'
    variables({
      :port => node[:port],
      :cores => instance[:cores],
      :default_core => instance[:default_core]
    })
  end

  instance[:cores].each do |core|
    directory core[:data_dir] do
      owner 'root'
      group 'root'
      mode '0777'
      recursive true
      action :create
    end
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

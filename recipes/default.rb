#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2013, David Radcliffe
#

include_recipe 'java'

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

directory node['solr']['data_dir'] do
  owner 'root'
  group 'root'
  action :create
end


#
# Cookbook Name:: solr
# Attributes:: default
#
# Copyright 2013, David Radcliffe
#

default['solr']['version']  = '4.6.1'
default['solr']['url']      = "https://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/solr-#{node['solr']['version']}.tgz"
default['solr']['data_dir'] = '/etc/solr'
default['solr']['dir'] = "/opt/solr-#{node['solr']['version']}"
default['solr']['port'] = 8984
default['solr']['zookeeper']['cluster_servers'] = ['zoo1.example.com:2181', 'zoo2.example.com:2181', 'zoo3.example.com:2181']
default['solr']['cloud']['shards'] = ['shard1', 'shard2']
default['solr']['cloud']['replicas'] = []
default['solr']['java']['xmx'] = "3072M"
default['solr']['java']['xms'] = "512M"
default['solr']['collection']['name'] = "example"
default['solr']['bootstrap_conf_dir'] = "./solr/conf"
default['solr']['log_dir'] = "/var/log/solr"

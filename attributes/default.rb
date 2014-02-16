#
# Cookbook Name:: solr
# Attributes:: default
#
# Copyright 2013, David Radcliffe
#

default['solr']['version']  = '4.6.1'
default['solr']['url']      = "https://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/solr-#{node['solr']['version']}.tgz"
default['solr']['dir'] = "/opt/solr-#{node['solr']['version']}"
default['solr']['zookeeper']['cluster_servers'] = ['zoo1.example.com:2181', 'zoo2.example.com:2181', 'zoo3.example.com:2181']
default['solr']['cloud']['shards'] = [
    {
        :name => 'shard1',
        :port => 8984,
        :cores => [
            {
                :name => 'test', :instance_dir => "core0", :data_dir => "/var/solr/shard1/core0/data",
                :name => 'dev', :instance_dir => "core1", :data_dir => "/var/solr/shard1/core1/data",
                :name => 'prod', :instance_dir => "core2", :data_dir => "/var/solr/shard1/core2/data",
            }
        ],
        :default_core => 'test'
    },
    {
        :name => 'shard2',
        :port => 8995,
        :cores => [
            {
                :name => 'test', :instance_dir => "core0", :data_dir => "/var/solr/shard2/core0/data",
                :name => 'dev', :instance_dir => "core1", :data_dir => "/var/solr/shard2/core1/data",
                :name => 'prod', :instance_dir => "core2", :data_dir => "/var/solr/shard2/core2/data",
            }
        ],
        :default_core => 'test'
    }
]
default['solr']['cloud']['replicas'] = []
default['solr']['java']['xmx'] = "3072M"
default['solr']['java']['xms'] = "512M"
default['solr']['collection']['name'] = "example"
default['solr']['bootstrap_conf_dir'] = "./solr/conf"
default['solr']['log_dir'] = "/var/log/solr"

default[:solr][:zookeeper][:cluster_servers] = ['zoo1.example.com:2181', 'zoo2.example.com:2181', 'zoo3.example.com:2181']
default[:solr][:cloud][:shards] = ['shard1', 'shard2']
default[:solr][:cloud][:replicas] = []
default[:solr][:java][:xmx] = "3072M"
default[:solr][:collection][:name] = "example"
default[:solr][:bootstrap_conf_dir] = "./solr/conf"
default[:solr][:log_dir] = "/var/log/solr"


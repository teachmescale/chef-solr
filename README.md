# chef-solr [![Build Status](https://travis-ci.org/dwradcliffe/chef-solr.png?branch=master)](https://travis-ci.org/dwradcliffe/chef-solr)

Installs [solr](http://lucene.apache.org/solr/) and starts the service.

## Recipes

- `default` - This will install java, download solr and setup the service
- `cloud` - installs `solr` based on shards and replicas configuration. Limitation: does not support distributed shards. E.g. The first n instances to start would become shards.

## Attributes

- `node['solr']['version']` - Version of solr to install
- `node['solr']['url']` - Url of solr source to download
- `node['solr']['data_dir']` - Location for solr data and config
- `node[:solr][:zookeeper][:cluster_servers]` - describes zookeper nodes. Defaults to `['zoo1.example.com:2181', 'zoo2.example.com:2181', 'zoo3.example.com:2181']`
- `node[:solr][:cloud][:shards]` - describes shards names. Should be set for master nodes. Defaults to `['shard1', 'shard2']`
- `node[:solr][:cloud][:replicas]` - describes replica names. Should be set for slave nodes. Defaults to `[]`
- `node[:solr][:java][:xmx]` - Max java heap size, defauls `"3072M"`
- `node[:solr][:collection][:name]` - SOLR collection name. Defaults to `"example"`
- `node[:solr][:bootstrap_conf_dir]` - SOLR bootstrap conf dir. Default to `"./solr/conf"`
- `node[:solr][:log_dir]` - log dir. Defaults to `"./solr/conf"`


## License and Author

License: [MIT](https://github.com/dwradcliffe/chef-solr/blob/master/LICENSE)

Author: [David Radcliffe](https://github.com/dwradcliffe)

Inspiration for the start script from [https://github.com/jbusby/solr-initd](https://github.com/jbusby/solr-initd)

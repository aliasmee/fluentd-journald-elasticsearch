# Fluentd-journald-elasticsearch

Collect and filter docker journald using fluentd, in a kubernetes cluster.

## Getting Started

These instructions will cover usage information and for the docker container 

### Prerequisities


In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

kubernetes cluster

* Docker Logging Driver on Node: journald
* Reliable elasticsearch cluster 

### Usage

#### Container Parameters

Run the container and mount the host directory /run/log/journal to the container's corresponding directory (This example: container's dir is /run/log/journal)

```shell
docker run -it --rm -v /run/log/journal:/run/log/journal fluentd-journald-elasticsearch
```
`Note:` The default log is output to host elasticsearch_logging: 9200

You can modify the default environment variable to specify the elasticsearch host when running the container. e.g:

```shell
docker run -it --rm -v /run/log/journal:/run/log/journal -e "FLUENT_ELASTICSEARCH_HOST=es-cluster-ip" fluentd-journald-elasticsearch
```

One of the log examples:
```json
{
"_index": "kubernetes-2018.01.28",
"_type": "fluentd",
"_id": "HMnVO2EBv8K-t54ZDxjW",
"_version": 1,
"_score": 1,
"_source": {
"Node": "dce-k8s-worker3",
"PRIORITY": "6",
"TRANSPORT": "journal",
"PID": "7630",
"COMM": "dockerd",
"CAP_EFFECTIVE": "3fffffffff",
"SYSTEMD_UNIT": "docker.service",
"BOOT_ID": "9c6a0630abe645f99ca1c4c88c196573",
"MACHINE_ID": "617f06359788ed0e86d064455995028d",
"CONTAINER_ID": "ad0f351daf0f",
"CONTAINER_ID_FULL": "ad0f351daf0f0c2429bbf53c5a980a27909c426fbeab50774ea9e5a14c08a27d",
"CONTAINER_NAME": "k8s_calico-node_calico-node-4vz7c_kube-system_bd7f55e3-0277-11e8-8327-0242ac130006_2",
"CONTAINER_TAG": "ad0f351daf0f",
"MESSAGE": "2018-01-28 03:30:55.221 [INFO][159] int_dataplane.go 705: Finished applying updates to dataplane. msecToApply=1.847487",
"SOURCE_REALTIME_TIMESTAMP": "1517110255221523",
"docker": {
"container_id": "ad0f351daf0f0c2429bbf53c5a980a27909c426fbeab50774ea9e5a14c08a27d"
},
"kubernetes": {
"container_name": "calico-node",
"namespace_name": "kube-system",
"pod_name": "calico-node-4vz7c"
},
"@timestamp": "2018-01-28T03:30:55.221677000+00:00"
}
}
```

#### Environment Variables
The following is the current dynamic environment variables
* `FLUENT_ELASTICSEARCH_HOST` - elasticsearch cluster ip address (the default value is elasticsearch_logging)
* `FLUENT_ELASTICSEARCH_PORT` - elasticsearch cluster port (default value is 9200 port)
* `FLUENT_ELASTICSEARCH_USER` - elasticsearch certified user [Optional]
* `FLUENT_ELASTICSEARCH_PASSWORD` - elasticsearch certified user's password [Optional]

#### Volumes

* `/run/log/journal` - OS systemd journald location, Or in the /var/log/journal directory,according to actual condition.

#### Useful File Locations

* `/bin/entrypoint.sh` - You also modify this script to add dynamic environment variables.
  

## Built With

* Base image fluent/fluentd:v1.1.0-debian
* [fluent-plugin-systemd v0.3.1](https://github.com/reevoo/fluent-plugin-systemd) plugin
* [fluent-plugin-rewrite-tag-filter](https://github.com/fluent/fluent-plugin-rewrite-tag-filter) plugin
* [fluent-plugin-kubernetes_metadata_filter](https://github.com/fabric8io/fluent-plugin-kubernetes_metadata_filter) plugin

## Find Us

* [GitHub](https://github.com/aliasmee/fluentd-journald-elasticsearch.git)
* [DockerHub](https://quay.io/repository/your/docker-repository)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **aliasmee** - *Initial work* - [@aliasmee](https://github.com/aliasmee)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

* [richm](https://github.com/kubernetes/kubernetes/issues/25975)

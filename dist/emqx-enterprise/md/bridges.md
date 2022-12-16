# Bridges

## bridge:bridges <a id='bridge-bridges'></a>
Configuration for MQTT bridges.


**Config paths**

 - <code>bridges</code>

**Env overrides**

 - <code>EMQX_BRIDGES</code>


**Fields**

- webhook: <code>{$name -> [bridge_webhook:config](others.md#bridge_webhook-config)}</code>
  WebHook to an HTTP server.

- mqtt: <code>{$name -> [bridge_mqtt:config](others.md#bridge_mqtt-config)}</code>
  MQTT bridges to/from another MQTT broker

- kafka: <code>{$name -> [bridge_kafka:config](others.md#bridge_kafka-config)}</code>
  Kafka Bridge Config

- hstreamdb: <code>{$name -> [bridge_hstreamdb:config](others.md#bridge_hstreamdb-config)}</code>
  HStreamDB Bridge Config

- gcp_pubsub: <code>{$name -> [bridge_gcp_pubsub:config](others.md#bridge_gcp_pubsub-config)}</code>
  EMQX Enterprise Config

- mysql: <code>{$name -> [bridge_mysql:config](others.md#bridge_mysql-config)}</code>
  MySQL Bridge Config

- mongodb_rs: <code>{$name -> [bridge_mongodb:mongodb_rs](others.md#bridge_mongodb-mongodb_rs)}</code>
  MongoDB Bridge Config

- mongodb_sharded: <code>{$name -> [bridge_mongodb:mongodb_sharded](others.md#bridge_mongodb-mongodb_sharded)}</code>
  MongoDB Bridge Config

- mongodb_single: <code>{$name -> [bridge_mongodb:mongodb_single](others.md#bridge_mongodb-mongodb_single)}</code>
  MongoDB Bridge Config

- influxdb_api_v1: <code>{$name -> [bridge_influxdb:influxdb_api_v1](others.md#bridge_influxdb-influxdb_api_v1)}</code>
  InfluxDB Bridge Config

- influxdb_api_v2: <code>{$name -> [bridge_influxdb:influxdb_api_v2](others.md#bridge_influxdb-influxdb_api_v2)}</code>
  InfluxDB Bridge Config

- redis_single: <code>{$name -> [bridge_redis:redis_single](others.md#bridge_redis-redis_single)}</code>
  Redis Bridge Config

- redis_sentinel: <code>{$name -> [bridge_redis:redis_sentinel](others.md#bridge_redis-redis_sentinel)}</code>
  Redis Bridge Config

- redis_cluster: <code>{$name -> [bridge_redis:redis_cluster](others.md#bridge_redis-redis_cluster)}</code>
  Redis Bridge Config


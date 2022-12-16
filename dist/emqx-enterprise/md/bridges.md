# Bridges

## bridge:bridges
Configuration for MQTT bridges.


**Config paths**

 - <code>bridges</code>


**Env overrides**

 - <code>EMQX_BRIDGES</code>



**Fields**

- webhook: <code>{$name -> [bridge_webhook:config](#bridge_webhook-config)}</code>

  WebHook to an HTTP server.

- mqtt: <code>{$name -> [bridge_mqtt:config](#bridge_mqtt-config)}</code>

  MQTT bridges to/from another MQTT broker

- kafka: <code>{$name -> [bridge_kafka:config](#bridge_kafka-config)}</code>

  Kafka Bridge Config

- hstreamdb: <code>{$name -> [bridge_hstreamdb:config](#bridge_hstreamdb-config)}</code>

  HStreamDB Bridge Config

- gcp_pubsub: <code>{$name -> [bridge_gcp_pubsub:config](#bridge_gcp_pubsub-config)}</code>

  EMQX Enterprise Config

- mysql: <code>{$name -> [bridge_mysql:config](#bridge_mysql-config)}</code>

  MySQL Bridge Config

- mongodb_rs: <code>{$name -> [bridge_mongodb:mongodb_rs](#bridge_mongodb-mongodb_rs)}</code>

  MongoDB Bridge Config

- mongodb_sharded: <code>{$name -> [bridge_mongodb:mongodb_sharded](#bridge_mongodb-mongodb_sharded)}</code>

  MongoDB Bridge Config

- mongodb_single: <code>{$name -> [bridge_mongodb:mongodb_single](#bridge_mongodb-mongodb_single)}</code>

  MongoDB Bridge Config

- influxdb_api_v1: <code>{$name -> [bridge_influxdb:influxdb_api_v1](#bridge_influxdb-influxdb_api_v1)}</code>

  InfluxDB Bridge Config

- influxdb_api_v2: <code>{$name -> [bridge_influxdb:influxdb_api_v2](#bridge_influxdb-influxdb_api_v2)}</code>

  InfluxDB Bridge Config

- redis_single: <code>{$name -> [bridge_redis:redis_single](#bridge_redis-redis_single)}</code>

  Redis Bridge Config

- redis_sentinel: <code>{$name -> [bridge_redis:redis_sentinel](#bridge_redis-redis_sentinel)}</code>

  Redis Bridge Config

- redis_cluster: <code>{$name -> [bridge_redis:redis_cluster](#bridge_redis-redis_cluster)}</code>

  Redis Bridge Config



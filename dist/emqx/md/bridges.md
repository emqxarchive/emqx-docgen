# Bridges

## bridge:bridges <a id='bridge-bridges'></a>
Configuration for MQTT bridges.

| Config paths | Env overrides |
|----------------------|---------------------------|
|  <code>bridges</code> | <code>EMQX_BRIDGES</code>  |


**Fields**

- webhook: <code>{$name -> [bridge_webhook:config](others.md#bridge_webhook-config)}</code>
  WebHook to an HTTP server.

- mqtt: <code>{$name -> [bridge_mqtt:config](others.md#bridge_mqtt-config)}</code>
  MQTT bridges to/from another MQTT broker


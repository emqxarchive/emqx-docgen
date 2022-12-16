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



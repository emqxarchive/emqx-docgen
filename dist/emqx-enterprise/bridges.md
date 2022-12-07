# Bridges

## bridge:bridges
Configuration for MQTT bridges.


**Config paths**

 - <code>bridges</code>


**Env overrides**

 - <code>EMQX_BRIDGES</code>



**Fields**

- webhook: <code>{$name -> [bridge:config](#bridge-config)}</code>

  WebHook to an HTTP server.

- mqtt: <code>{$name -> [ingress](#ingress) | [egress](#egress)}</code>

  MQTT bridges to/from another MQTT broker



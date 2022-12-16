# Gateways

## gateway:clientinfo_override
ClientInfo override.


**Config paths**

 - <code>gateway.coap.clientinfo_override</code>
 - <code>gateway.exproto.clientinfo_override</code>
 - <code>gateway.lwm2m.clientinfo_override</code>
 - <code>gateway.mqttsn.clientinfo_override</code>
 - <code>gateway.stomp.clientinfo_override</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__CLIENTINFO_OVERRIDE</code>
 - <code>EMQX_GATEWAY__EXPROTO__CLIENTINFO_OVERRIDE</code>
 - <code>EMQX_GATEWAY__LWM2M__CLIENTINFO_OVERRIDE</code>
 - <code>EMQX_GATEWAY__MQTTSN__CLIENTINFO_OVERRIDE</code>
 - <code>EMQX_GATEWAY__STOMP__CLIENTINFO_OVERRIDE</code>


**Fields**

- username: <code>binary()</code>
  Template for overriding username.

- password: <code>binary()</code>
  Template for overriding password.

- clientid: <code>binary()</code>
  Template for overriding clientid.


## gateway:coap
The CoAP protocol gateway provides EMQX with the access capability of the CoAP protocol.
It allows publishing, subscribing, and receiving messages to EMQX in accordance
with a certain defined CoAP message format.


**Config paths**

 - <code>gateway.coap</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP</code>


**Fields**

- heartbeat: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The gateway server required minimum heartbeat interval.
  When connection mode is enabled, this parameter is used to set the minimum heartbeat interval for the connection to be alive

- connection_required: <code>boolean()</code>
  * default: 
  `false`

  Enable or disable connection mode.
  Connection mode is a feature of non-standard protocols. When connection mode is enabled, it is necessary to maintain the creation, authentication and alive of connection resources

- notify_type: <code>non | con | qos</code>
  * default: 
  `qos`

  The Notification Message will be delivered to the CoAP client if a new message received on an observed topic.
  The type of delivered coap message can be set to:
    - non: Non-confirmable;
    - con: Confirmable;
    - qos: Mapping from QoS type of received message, QoS0 -> non, QoS1,2 -> con

- subscribe_qos: <code>qos0 | qos1 | qos2 | coap</code>
  * default: 
  `coap`

  The Default QoS Level indicator for subscribe request.
  This option specifies the QoS level for the CoAP Client when establishing a subscription membership, if the subscribe request is not carried `qos` option. The indicator can be set to:
    - qos0, qos1, qos2: Fixed default QoS level
    - coap: Dynamic QoS level by the message type of subscribe request
      * qos0: If the subscribe request is non-confirmable
      * qos1: If the subscribe request is confirmable

- publish_qos: <code>qos0 | qos1 | qos2 | coap</code>
  * default: 
  `coap`

  The Default QoS Level indicator for publish request.
  This option specifies the QoS level for the CoAP Client when publishing a message to EMQX PUB/SUB system, if the publish request is not carried `qos` option. The indicator can be set to:
    - qos0, qos1, qos2: Fixed default QoS level
    - coap: Dynamic QoS level by the message type of publish request
      * qos0: If the publish request is non-confirmable
      * qos1: If the publish request is confirmable

- mountpoint: <code>binary()</code>
  * default: 
  `""`

   

- listeners: <code>[gateway:udp_listeners](#gateway-udp_listeners)</code>
  Settings for the UDP listeners.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable this gateway

- enable_stats: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable client process statistic

- idle_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The idle time of the client connection process. It has two purposes:
    1. A newly created client process that does not receive any client requests after that time will be closed directly.
    2. A running client process that does not receive any client requests after this time will go into hibernation to save resources.

- clientinfo_override: <code>[gateway:clientinfo_override](#gateway-clientinfo_override)</code>
  ClientInfo override.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs


## gateway:dtls_listener
Settings for the DTLS listener.


**Config paths**

 - <code>gateway.coap.listeners.dtls.$name</code>
 - <code>gateway.exproto.listeners.dtls.$name</code>
 - <code>gateway.lwm2m.listeners.dtls.$name</code>
 - <code>gateway.mqttsn.listeners.dtls.$name</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME</code>


**Fields**

- acceptors: <code>integer()</code>
  * default: 
  `16`

  Size of the acceptor pool.

- udp_options: <code>[gateway:udp_opts](#gateway-udp_opts)</code>


- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable the listener.

- bind: <code>emqx_gateway_schema:ip_port() | integer()</code>
  The IP address and port that the listener will bind.

- max_connections: <code>integer()</code>
  * default: 
  `1024`

  Maximum number of concurrent connections.

- max_conn_rate: <code>integer()</code>
  * default: 
  `1000`

  Maximum connections per second.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs

- enable_authn: <code>boolean()</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener. 
  When set to <code>false</code> clients will be allowed to connect without authentication.

- mountpoint: <code>binary()</code>
  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message is delivered to the subscriber. The mountpoint is a way that users can use to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint` set to `some_tenant`, then the client actually subscribes to the topic `some_tenant/t`. Similarly, if another client B (connected to the same listener as the client A) sends a message to topic `t`, the message is routed to all the clients subscribed `some_tenant/t`, so client A will receive the message, with topic name `t`. Set to `""` to disable the feature.
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- access_rules: <code>[string()]</code>
  * default: 
  `[]`

  The access control rules for this listener.
  See: https://github.com/emqtt/esockd#allowdeny

- dtls_options: <code>[gateway:dtls_opts](#gateway-dtls_opts)</code>
  DTLS socket options


## gateway:dtls_opts
Settings for the DTLS protocol.


**Config paths**

 - <code>gateway.coap.listeners.dtls.$name.dtls_options</code>
 - <code>gateway.exproto.listeners.dtls.$name.dtls_options</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.dtls_options</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.dtls_options</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__DTLS_OPTIONS</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__DTLS_OPTIONS</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__DTLS_OPTIONS</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__DTLS_OPTIONS</code>


**Fields**

- cacertfile: <code>binary()</code>
  Trusted PEM format CA certificates bundle file.<br/>
  The certificates in this file are used to verify the TLS peer's certificates.
  Append new certificates to the file if new CAs are to be trusted.
  There is no need to restart EMQX to have the updated file loaded, because
  the system regularly checks if file has been updated (and reload).<br/>
  NOTE: invalidating (deleting) a certificate from the file will not affect
  already established connections.

- certfile: <code>binary()</code>
  PEM format certificates chain file.<br/>
  The certificates in this file should be in reversed order of the certificate
  issue chain. That is, the host's certificate should be placed in the beginning
  of the file, followed by the immediate issuer certificate and so on.
  Although the root CA certificate is optional, it should be placed at the end of
  the file if it is to be added.

- keyfile: <code>binary()</code>
  PEM format private key file. 

- verify: <code>verify_peer | verify_none</code>
  * default: 
  `verify_none`

  Enable or disable peer verification. 

- reuse_sessions: <code>boolean()</code>
  * default: 
  `true`

  Enable TLS session reuse. 

- depth: <code>integer()</code>
  * default: 
  `10`

  Maximum number of non-self-issued intermediate certificates that can follow the peer certificate in a valid certification path.
  So, if depth is 0 the PEER must be signed by the trusted ROOT-CA directly;<br/>
  if 1 the path can be PEER, Intermediate-CA, ROOT-CA;<br/>
  if 2 the path can be PEER, Intermediate-CA1, Intermediate-CA2, ROOT-CA.<br/>

- password: <code>string()</code>
  String containing the user's password.
  Only used if the private key file is password-protected.

- versions: <code>[atom()]</code>
  * default: 
  `[dtlsv1.2, dtlsv1]`

  All TLS/DTLS versions to be supported.<br/>
  NOTE: PSK ciphers are suppressed by 'tlsv1.3' version config.<br/>
  In case PSK cipher suites are intended, make sure to configure
  <code>['tlsv1.2', 'tlsv1.1']</code> here.

- ciphers: <code>[string()]</code>
  * default: 
  `[]`

  This config holds TLS cipher suite names separated by comma,
  or as an array of strings. e.g.
  <code>"TLS_AES_256_GCM_SHA384,TLS_AES_128_GCM_SHA256"</code> or
  <code>["TLS_AES_256_GCM_SHA384","TLS_AES_128_GCM_SHA256"]</code>.
  <br/>
  Ciphers (and their ordering) define the way in which the
  client and server encrypts information over the network connection.
  Selecting a good cipher suite is critical for the
  application's data security, confidentiality and performance.
  The names should be in OpenSSL string format (not RFC format).
  All default values and examples provided by EMQX config
  documentation are all in OpenSSL format.<br/>
  NOTE: Certain cipher suites are only compatible with
  specific TLS <code>versions</code> ('tlsv1.1', 'tlsv1.2' or 'tlsv1.3')
  incompatible cipher suites will be silently dropped.
  For instance, if only 'tlsv1.3' is given in the <code>versions</code>,
  configuring cipher suites for other versions will have no effect.
  <br/>
  NOTE: PSK ciphers are suppressed by 'tlsv1.3' version config<br/>
  If PSK cipher suites are intended, 'tlsv1.3' should be disabled from <code>versions</code>.<br/>
  PSK cipher suites: <code>"RSA-PSK-AES256-GCM-SHA384,RSA-PSK-AES256-CBC-SHA384,
  RSA-PSK-AES128-GCM-SHA256,RSA-PSK-AES128-CBC-SHA256,
  RSA-PSK-AES256-CBC-SHA,RSA-PSK-AES128-CBC-SHA,
  RSA-PSK-DES-CBC3-SHA,RSA-PSK-RC4-SHA"</code><br/>

- user_lookup_fun: <code>string()</code>
  * default: 
  `"emqx_tls_psk:lookup"`

  EMQX-internal callback that is used to lookup pre-shared key (PSK) identity. 

- secure_renegotiate: <code>boolean()</code>
  * default: 
  `true`

  SSL parameter renegotiation is a feature that allows a client and a server
  to renegotiate the parameters of the SSL connection on the fly.
  RFC 5746 defines a more secure way of doing this. By enabling secure renegotiation,
  you drop support for the insecure renegotiation, prone to MitM attacks.

- dhfile: <code>string()</code>
  Path to a file containing PEM-encoded Diffie-Hellman parameters
  to be used by the server if a cipher suite using Diffie-Hellman
  key exchange is negotiated. If not specified, default parameters
  are used.<br/>
  NOTE: The <code>dhfile</code> option is not supported by TLS 1.3.

- fail_if_no_peer_cert: <code>boolean()</code>
  * default: 
  `false`

  Used together with {verify, verify_peer} by an TLS/DTLS server.
  If set to true, the server fails if the client does not have a
  certificate to send, that is, sends an empty certificate.
  If set to false, it fails only if the client sends an invalid
  certificate (an empty certificate is considered valid).

- honor_cipher_order: <code>boolean()</code>
  * default: 
  `true`

  An important security setting, it forces the cipher to be set based
   on the server-specified order instead of the client-specified order,
   hence enforcing the (usually more properly configured) security
   ordering of the server administrator.

- client_renegotiation: <code>boolean()</code>
  * default: 
  `true`

  In protocols that support client-initiated renegotiation,
  the cost of resources of such an operation is higher for the server than the client.
  This can act as a vector for denial of service attacks.
  The SSL application already takes measures to counter-act such attempts,
  but client-initiated renegotiation can be strictly disabled by setting this option to false.
  The default value is true. Note that disabling renegotiation can result in
  long-lived connections becoming unusable due to limits on
  the number of messages the underlying cipher suite can encipher.

- handshake_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"15s"`

  Maximum time duration allowed for the handshake to complete

- gc_after_handshake: <code>boolean()</code>
  * default: 
  `false`

  Memory usage tuning. If enabled, will immediately perform a garbage collection after
  the TLS/SSL handshake.


## gateway:exproto
Settings for EMQX extension protocol (exproto).


**Config paths**

 - <code>gateway.exproto</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO</code>


**Fields**

- server: <code>[gateway:exproto_grpc_server](#gateway-exproto_grpc_server)</code>
  Configurations for starting the <code>ConnectionAdapter</code> service

- handler: <code>[gateway:exproto_grpc_handler](#gateway-exproto_grpc_handler)</code>
  Configurations for request to <code>ConnectionHandler</code> service

- mountpoint: <code>binary()</code>
  * default: 
  `""`

   

- listeners: <code>[gateway:tcp_udp_listeners](#gateway-tcp_udp_listeners)</code>
  Settings for the listeners.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable this gateway

- enable_stats: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable client process statistic

- idle_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The idle time of the client connection process. It has two purposes:
    1. A newly created client process that does not receive any client requests after that time will be closed directly.
    2. A running client process that does not receive any client requests after this time will go into hibernation to save resources.

- clientinfo_override: <code>[gateway:clientinfo_override](#gateway-clientinfo_override)</code>
  ClientInfo override.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs


## gateway:exproto_grpc_handler
Settings for the exproto gRPC connection handler.


**Config paths**

 - <code>gateway.exproto.handler</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__HANDLER</code>


**Fields**

- address: <code>binary()</code>
  gRPC server address.

- ssl_options: <code>[broker:ssl_client_opts](#broker-ssl_client_opts)</code>
  SSL configuration for the gRPC client.


## gateway:exproto_grpc_server
Settings for the exproto gRPC server.


**Config paths**

 - <code>gateway.exproto.server</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__SERVER</code>


**Fields**

- bind: <code>emqx_gateway_schema:ip_port() | integer()</code>
  Listening address and port for the gRPC server.

- ssl_options: <code>[gateway:ssl_server_opts](#gateway-ssl_server_opts)</code>
  SSL configuration for the gRPC server.


## gateway
EMQX Gateway configuration root.


**Config paths**

 - <code>gateway</code>

**Env overrides**

 - <code>EMQX_GATEWAY</code>


**Fields**

- stomp: <code>[gateway:stomp](#gateway-stomp)</code>
  The Stomp Gateway configuration.
  This gateway supports v1.2/1.1/1.0

- mqttsn: <code>[gateway:mqttsn](#gateway-mqttsn)</code>
  The MQTT-SN Gateway configuration.
  This gateway only supports the v1.2 protocol

- coap: <code>[gateway:coap](#gateway-coap)</code>
  The CoAP Gateway configuration.
  This gateway is implemented based on RFC-7252 and https://core-wg.github.io/coap-pubsub/draft-ietf-core-pubsub.html

- lwm2m: <code>[gateway:lwm2m](#gateway-lwm2m)</code>
  The LwM2M Gateway configuration. This gateway only supports the v1.0.1 protocol.

- exproto: <code>[gateway:exproto](#gateway-exproto)</code>
  The Extension Protocol configuration


## gateway:lwm2m
The LwM2M protocol gateway.


**Config paths**

 - <code>gateway.lwm2m</code>

**Env overrides**

 - <code>EMQX_GATEWAY__LWM2M</code>


**Fields**

- xml_dir: <code>binary()</code>
  The Directory for LwM2M Resource definition.

- lifetime_min: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"15s"`

  Minimum value of lifetime allowed to be set by the LwM2M client.

- lifetime_max: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"86400s"`

  Maximum value of lifetime allowed to be set by the LwM2M client.

- qmode_time_window: <code>emqx_gateway_schema:duration_s()</code>
  * default: 
  `"22s"`

  The value of the time window during which the network link is considered valid by the LwM2M Gateway in QMode mode.
  For example, after receiving an update message from a client, any messages within this time window are sent directly to the LwM2M client, and all messages beyond this time window are temporarily stored in memory.

- auto_observe: <code>boolean()</code>
  * default: 
  `false`

  Automatically observe the object list of REGISTER packet.

- update_msg_publish_condition: <code>always | contains_object_list</code>
  * default: 
  `contains_object_list`

  Policy for publishing UPDATE event message.
    - always: send update events as long as the UPDATE request is received.
    - contains_object_list: send update events only if the UPDATE request carries any Object List

- translators: <code>[gateway:lwm2m_translators](#gateway-lwm2m_translators)</code>
  Topic configuration for LwM2M's gateway publishing and subscription.

- mountpoint: <code>binary()</code>
  * default: 
  `"lwm2m/${endpoint_name}/"`

   

- listeners: <code>[gateway:udp_listeners](#gateway-udp_listeners)</code>
  Settings for the UDP listeners.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable this gateway

- enable_stats: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable client process statistic

- idle_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The idle time of the client connection process. It has two purposes:
    1. A newly created client process that does not receive any client requests after that time will be closed directly.
    2. A running client process that does not receive any client requests after this time will go into hibernation to save resources.

- clientinfo_override: <code>[gateway:clientinfo_override](#gateway-clientinfo_override)</code>
  ClientInfo override.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs


## gateway:lwm2m_translators
MQTT topics that correspond to LwM2M events.


**Config paths**

 - <code>gateway.lwm2m.translators</code>

**Env overrides**

 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS</code>


**Fields**

- command: <code>[gateway:translator](#gateway-translator)</code>
  The topic for receiving downstream commands.
  For each new LwM2M client that succeeds in going online, the gateway creates a subscription relationship to receive downstream commands and send it to the LwM2M client

- response: <code>[gateway:translator](#gateway-translator)</code>
  The topic for gateway to publish the acknowledge events from LwM2M client

- notify: <code>[gateway:translator](#gateway-translator)</code>
  The topic for gateway to publish the notify events from LwM2M client.
  After succeed observe a resource of LwM2M client, Gateway will send the notify events via this topic, if the client reports any resource changes

- register: <code>[gateway:translator](#gateway-translator)</code>
  The topic for gateway to publish the register events from LwM2M client.

- update: <code>[gateway:translator](#gateway-translator)</code>
  The topic for gateway to publish the update events from LwM2M client


## gateway:mqttsn
The MQTT-SN (MQTT for Sensor Networks) protocol gateway.


**Config paths**

 - <code>gateway.mqttsn</code>

**Env overrides**

 - <code>EMQX_GATEWAY__MQTTSN</code>


**Fields**

- gateway_id: <code>integer()</code>
  * default: 
  `1`

  MQTT-SN Gateway ID.
  When the <code>broadcast</code> option is enabled, the gateway will broadcast ADVERTISE message with this value

- broadcast: <code>boolean()</code>
  * default: 
  `false`

  Whether to periodically broadcast ADVERTISE messages

- enable_qos3: <code>boolean()</code>
  * default: 
  `true`

  Allows connectionless clients to publish messages with a Qos of -1.
  This feature is defined for very simple client implementations which do not support any other features except this one. There is no connection setup nor tear down, no registration nor subscription. The client just sends its 'PUBLISH' messages to a GW

- subs_resume: <code>boolean()</code>
  * default: 
  `false`

  Whether to initiate all subscribed topic name registration messages to the client after the Session has been taken over by a new channel

- predefined: <code>[[gateway:mqttsn_predefined](#gateway-mqttsn_predefined)]</code>
  * default: 
  `[]`

  The pre-defined topic IDs and topic names.
  A 'pre-defined' topic ID is a topic ID whose mapping to a topic name is known in advance by both the client's application and the gateway

- mountpoint: <code>binary()</code>
  * default: 
  `""`

   

- listeners: <code>[gateway:udp_listeners](#gateway-udp_listeners)</code>
  Settings for the UDP listeners.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable this gateway

- enable_stats: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable client process statistic

- idle_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The idle time of the client connection process. It has two purposes:
    1. A newly created client process that does not receive any client requests after that time will be closed directly.
    2. A running client process that does not receive any client requests after this time will go into hibernation to save resources.

- clientinfo_override: <code>[gateway:clientinfo_override](#gateway-clientinfo_override)</code>
  ClientInfo override.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs


## gateway:mqttsn_predefined
The pre-defined topic name corresponding to the pre-defined topic
ID of N.

Note: the pre-defined topic ID of 0 is reserved.


**Config paths**

 - <code>gateway.mqttsn.predefined.$INDEX</code>

**Env overrides**

 - <code>EMQX_GATEWAY__MQTTSN__PREDEFINED__$INDEX</code>


**Fields**

- id: <code>integer()</code>
  Topic ID. Range: 1-65535

- topic: <code>binary()</code>
  Topic Name


## gateway:ssl_listener
Settings for the SSL listener.


**Config paths**

 - <code>gateway.exproto.listeners.ssl.$name</code>
 - <code>gateway.stomp.listeners.ssl.$name</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME</code>


**Fields**

- acceptors: <code>integer()</code>
  * default: 
  `16`

  Size of the acceptor pool.

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>
  Setting the TCP socket options.

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"15s"`

  Timeout for proxy protocol.
  EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable the listener.

- bind: <code>emqx_gateway_schema:ip_port() | integer()</code>
  The IP address and port that the listener will bind.

- max_connections: <code>integer()</code>
  * default: 
  `1024`

  Maximum number of concurrent connections.

- max_conn_rate: <code>integer()</code>
  * default: 
  `1000`

  Maximum connections per second.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs

- enable_authn: <code>boolean()</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener. 
  When set to <code>false</code> clients will be allowed to connect without authentication.

- mountpoint: <code>binary()</code>
  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message is delivered to the subscriber. The mountpoint is a way that users can use to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint` set to `some_tenant`, then the client actually subscribes to the topic `some_tenant/t`. Similarly, if another client B (connected to the same listener as the client A) sends a message to topic `t`, the message is routed to all the clients subscribed `some_tenant/t`, so client A will receive the message, with topic name `t`. Set to `""` to disable the feature.
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- access_rules: <code>[string()]</code>
  * default: 
  `[]`

  The access control rules for this listener.
  See: https://github.com/emqtt/esockd#allowdeny

- ssl_options: <code>[broker:listener_ssl_opts](#broker-listener_ssl_opts)</code>
  SSL Socket options.


## gateway:ssl_server_opts
SSL configuration for the server.


**Config paths**

 - <code>gateway.exproto.server.ssl_options</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__SERVER__SSL_OPTIONS</code>


**Fields**

- cacertfile: <code>binary()</code>
  Trusted PEM format CA certificates bundle file.<br/>
  The certificates in this file are used to verify the TLS peer's certificates.
  Append new certificates to the file if new CAs are to be trusted.
  There is no need to restart EMQX to have the updated file loaded, because
  the system regularly checks if file has been updated (and reload).<br/>
  NOTE: invalidating (deleting) a certificate from the file will not affect
  already established connections.

- certfile: <code>binary()</code>
  PEM format certificates chain file.<br/>
  The certificates in this file should be in reversed order of the certificate
  issue chain. That is, the host's certificate should be placed in the beginning
  of the file, followed by the immediate issuer certificate and so on.
  Although the root CA certificate is optional, it should be placed at the end of
  the file if it is to be added.

- keyfile: <code>binary()</code>
  PEM format private key file. 

- verify: <code>verify_peer | verify_none</code>
  * default: 
  `verify_none`

  Enable or disable peer verification. 

- reuse_sessions: <code>boolean()</code>
  * default: 
  `true`

  Enable TLS session reuse. 

- depth: <code>integer()</code>
  * default: 
  `10`

  Maximum number of non-self-issued intermediate certificates that can follow the peer certificate in a valid certification path.
  So, if depth is 0 the PEER must be signed by the trusted ROOT-CA directly;<br/>
  if 1 the path can be PEER, Intermediate-CA, ROOT-CA;<br/>
  if 2 the path can be PEER, Intermediate-CA1, Intermediate-CA2, ROOT-CA.<br/>

- password: <code>string()</code>
  String containing the user's password.
  Only used if the private key file is password-protected.

- versions: <code>[atom()]</code>
  * default: 
  `[tlsv1.3, tlsv1.2, tlsv1.1, tlsv1]`

  All TLS/DTLS versions to be supported.<br/>
  NOTE: PSK ciphers are suppressed by 'tlsv1.3' version config.<br/>
  In case PSK cipher suites are intended, make sure to configure
  <code>['tlsv1.2', 'tlsv1.1']</code> here.

- ciphers: <code>[string()]</code>
  * default: 
  `[]`

  This config holds TLS cipher suite names separated by comma,
  or as an array of strings. e.g.
  <code>"TLS_AES_256_GCM_SHA384,TLS_AES_128_GCM_SHA256"</code> or
  <code>["TLS_AES_256_GCM_SHA384","TLS_AES_128_GCM_SHA256"]</code>.
  <br/>
  Ciphers (and their ordering) define the way in which the
  client and server encrypts information over the network connection.
  Selecting a good cipher suite is critical for the
  application's data security, confidentiality and performance.
  The names should be in OpenSSL string format (not RFC format).
  All default values and examples provided by EMQX config
  documentation are all in OpenSSL format.<br/>
  NOTE: Certain cipher suites are only compatible with
  specific TLS <code>versions</code> ('tlsv1.1', 'tlsv1.2' or 'tlsv1.3')
  incompatible cipher suites will be silently dropped.
  For instance, if only 'tlsv1.3' is given in the <code>versions</code>,
  configuring cipher suites for other versions will have no effect.
  <br/>
  NOTE: PSK ciphers are suppressed by 'tlsv1.3' version config<br/>
  If PSK cipher suites are intended, 'tlsv1.3' should be disabled from <code>versions</code>.<br/>
  PSK cipher suites: <code>"RSA-PSK-AES256-GCM-SHA384,RSA-PSK-AES256-CBC-SHA384,
  RSA-PSK-AES128-GCM-SHA256,RSA-PSK-AES128-CBC-SHA256,
  RSA-PSK-AES256-CBC-SHA,RSA-PSK-AES128-CBC-SHA,
  RSA-PSK-DES-CBC3-SHA,RSA-PSK-RC4-SHA"</code><br/>

- user_lookup_fun: <code>string()</code>
  * default: 
  `"emqx_tls_psk:lookup"`

  EMQX-internal callback that is used to lookup pre-shared key (PSK) identity. 

- secure_renegotiate: <code>boolean()</code>
  * default: 
  `true`

  SSL parameter renegotiation is a feature that allows a client and a server
  to renegotiate the parameters of the SSL connection on the fly.
  RFC 5746 defines a more secure way of doing this. By enabling secure renegotiation,
  you drop support for the insecure renegotiation, prone to MitM attacks.

- dhfile: <code>string()</code>
  Path to a file containing PEM-encoded Diffie-Hellman parameters
  to be used by the server if a cipher suite using Diffie-Hellman
  key exchange is negotiated. If not specified, default parameters
  are used.<br/>
  NOTE: The <code>dhfile</code> option is not supported by TLS 1.3.

- fail_if_no_peer_cert: <code>boolean()</code>
  * default: 
  `false`

  Used together with {verify, verify_peer} by an TLS/DTLS server.
  If set to true, the server fails if the client does not have a
  certificate to send, that is, sends an empty certificate.
  If set to false, it fails only if the client sends an invalid
  certificate (an empty certificate is considered valid).

- honor_cipher_order: <code>boolean()</code>
  * default: 
  `true`

  An important security setting, it forces the cipher to be set based
   on the server-specified order instead of the client-specified order,
   hence enforcing the (usually more properly configured) security
   ordering of the server administrator.

- client_renegotiation: <code>boolean()</code>
  * default: 
  `true`

  In protocols that support client-initiated renegotiation,
  the cost of resources of such an operation is higher for the server than the client.
  This can act as a vector for denial of service attacks.
  The SSL application already takes measures to counter-act such attempts,
  but client-initiated renegotiation can be strictly disabled by setting this option to false.
  The default value is true. Note that disabling renegotiation can result in
  long-lived connections becoming unusable due to limits on
  the number of messages the underlying cipher suite can encipher.

- handshake_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"15s"`

  Maximum time duration allowed for the handshake to complete


## gateway:stomp
The STOMP protocol gateway provides EMQX with the ability to access STOMP
(Simple (or Streaming) Text Orientated Messaging Protocol) protocol.


**Config paths**

 - <code>gateway.stomp</code>

**Env overrides**

 - <code>EMQX_GATEWAY__STOMP</code>


**Fields**

- frame: <code>[gateway:stomp_frame](#gateway-stomp_frame)</code>


- mountpoint: <code>binary()</code>
  * default: 
  `""`

   

- listeners: <code>[gateway:tcp_listeners](#gateway-tcp_listeners)</code>
  Settings for the TCP listeners.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable this gateway

- enable_stats: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable client process statistic

- idle_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"30s"`

  The idle time of the client connection process. It has two purposes:
    1. A newly created client process that does not receive any client requests after that time will be closed directly.
    2. A running client process that does not receive any client requests after this time will go into hibernation to save resources.

- clientinfo_override: <code>[gateway:clientinfo_override](#gateway-clientinfo_override)</code>
  ClientInfo override.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs


## gateway:stomp_frame
Size limits for the STOMP frames.


**Config paths**

 - <code>gateway.stomp.frame</code>

**Env overrides**

 - <code>EMQX_GATEWAY__STOMP__FRAME</code>


**Fields**

- max_headers: <code>non_neg_integer()</code>
  * default: 
  `10`

  The maximum number of Header

- max_headers_length: <code>non_neg_integer()</code>
  * default: 
  `1024`

  The maximum string length of the Header Value

- max_body_length: <code>integer()</code>
  * default: 
  `65536`

  Maximum number of bytes of Body allowed per Stomp packet


## gateway:tcp_listener
Settings for the TCP listener.


**Config paths**

 - <code>gateway.exproto.listeners.tcp.$name</code>
 - <code>gateway.stomp.listeners.tcp.$name</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME</code>


**Fields**

- acceptors: <code>integer()</code>
  * default: 
  `16`

  Size of the acceptor pool.

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>
  Setting the TCP socket options.

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_gateway_schema:duration()</code>
  * default: 
  `"15s"`

  Timeout for proxy protocol.
  EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable the listener.

- bind: <code>emqx_gateway_schema:ip_port() | integer()</code>
  The IP address and port that the listener will bind.

- max_connections: <code>integer()</code>
  * default: 
  `1024`

  Maximum number of concurrent connections.

- max_conn_rate: <code>integer()</code>
  * default: 
  `1000`

  Maximum connections per second.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs

- enable_authn: <code>boolean()</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener. 
  When set to <code>false</code> clients will be allowed to connect without authentication.

- mountpoint: <code>binary()</code>
  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message is delivered to the subscriber. The mountpoint is a way that users can use to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint` set to `some_tenant`, then the client actually subscribes to the topic `some_tenant/t`. Similarly, if another client B (connected to the same listener as the client A) sends a message to topic `t`, the message is routed to all the clients subscribed `some_tenant/t`, so client A will receive the message, with topic name `t`. Set to `""` to disable the feature.
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- access_rules: <code>[string()]</code>
  * default: 
  `[]`

  The access control rules for this listener.
  See: https://github.com/emqtt/esockd#allowdeny


## gateway:tcp_listeners
Settings for the TCP listeners.


**Config paths**

 - <code>gateway.stomp.listeners</code>

**Env overrides**

 - <code>EMQX_GATEWAY__STOMP__LISTENERS</code>


**Fields**

- tcp: <code>{$name -> [gateway:tcp_listener](#gateway-tcp_listener)}</code>
   

- ssl: <code>{$name -> [gateway:ssl_listener](#gateway-ssl_listener)}</code>
   


## gateway:tcp_udp_listeners
Settings for the listeners.


**Config paths**

 - <code>gateway.exproto.listeners</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS</code>


**Fields**

- tcp: <code>{$name -> [gateway:tcp_listener](#gateway-tcp_listener)}</code>
   

- ssl: <code>{$name -> [gateway:ssl_listener](#gateway-ssl_listener)}</code>
   

- udp: <code>{$name -> [gateway:udp_listener](#gateway-udp_listener)}</code>
   

- dtls: <code>{$name -> [gateway:dtls_listener](#gateway-dtls_listener)}</code>
   


## gateway:translator
MQTT topic that corresponds to a particular type of event.


**Config paths**

 - <code>gateway.lwm2m.translators.command</code>
 - <code>gateway.lwm2m.translators.notify</code>
 - <code>gateway.lwm2m.translators.register</code>
 - <code>gateway.lwm2m.translators.response</code>
 - <code>gateway.lwm2m.translators.update</code>

**Env overrides**

 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS__COMMAND</code>
 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS__NOTIFY</code>
 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS__REGISTER</code>
 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS__RESPONSE</code>
 - <code>EMQX_GATEWAY__LWM2M__TRANSLATORS__UPDATE</code>


**Fields**

- topic: <code>binary()</code>
  Topic Name

- qos: <code>qos()</code>
  * default: 
  `0`

  QoS Level


## gateway:udp_listener
Settings for the UDP listener.


**Config paths**

 - <code>gateway.coap.listeners.udp.$name</code>
 - <code>gateway.exproto.listeners.udp.$name</code>
 - <code>gateway.lwm2m.listeners.udp.$name</code>
 - <code>gateway.mqttsn.listeners.udp.$name</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME</code>


**Fields**

- udp_options: <code>[gateway:udp_opts](#gateway-udp_opts)</code>


- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable the listener.

- bind: <code>emqx_gateway_schema:ip_port() | integer()</code>
  The IP address and port that the listener will bind.

- max_connections: <code>integer()</code>
  * default: 
  `1024`

  Maximum number of concurrent connections.

- max_conn_rate: <code>integer()</code>
  * default: 
  `1000`

  Maximum connections per second.

- authentication: <code>[authn-builtin_db:authentication](#authn-builtin_db-authentication) | [authn-mysql:authentication](#authn-mysql-authentication) | [authn-postgresql:authentication](#authn-postgresql-authentication) | [authn-mongodb:standalone](#authn-mongodb-standalone) | [authn-mongodb:replica-set](#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](#authn-mongodb-sharded-cluster) | [authn-redis:standalone](#authn-redis-standalone) | [authn-redis:cluster](#authn-redis-cluster) | [authn-redis:sentinel](#authn-redis-sentinel) | [authn-http:get](#authn-http-get) | [authn-http:post](#authn-http-post) | [authn-jwt:hmac-based](#authn-jwt-hmac-based) | [authn-jwt:public-key](#authn-jwt-public-key) | [authn-jwt:jwks](#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](#authn-scram-builtin_db-authentication)</code>
  Default authentication configs for all the gateway listeners. For per-listener overrides see <code>authentication</code>
   in listener configs

- enable_authn: <code>boolean()</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener. 
  When set to <code>false</code> clients will be allowed to connect without authentication.

- mountpoint: <code>binary()</code>
  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message is delivered to the subscriber. The mountpoint is a way that users can use to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint` set to `some_tenant`, then the client actually subscribes to the topic `some_tenant/t`. Similarly, if another client B (connected to the same listener as the client A) sends a message to topic `t`, the message is routed to all the clients subscribed `some_tenant/t`, so client A will receive the message, with topic name `t`. Set to `""` to disable the feature.
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- access_rules: <code>[string()]</code>
  * default: 
  `[]`

  The access control rules for this listener.
  See: https://github.com/emqtt/esockd#allowdeny


## gateway:udp_listeners
Settings for the UDP listeners.


**Config paths**

 - <code>gateway.coap.listeners</code>
 - <code>gateway.lwm2m.listeners</code>
 - <code>gateway.mqttsn.listeners</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__LISTENERS</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS</code>


**Fields**

- udp: <code>{$name -> [gateway:udp_listener](#gateway-udp_listener)}</code>
   

- dtls: <code>{$name -> [gateway:dtls_listener](#gateway-dtls_listener)}</code>
   


## gateway:udp_opts
Settings for the UDP sockets.


**Config paths**

 - <code>gateway.coap.listeners.dtls.$name.udp_options</code>
 - <code>gateway.coap.listeners.udp.$name.udp_options</code>
 - <code>gateway.exproto.listeners.dtls.$name.udp_options</code>
 - <code>gateway.exproto.listeners.udp.$name.udp_options</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.udp_options</code>
 - <code>gateway.lwm2m.listeners.udp.$name.udp_options</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.udp_options</code>
 - <code>gateway.mqttsn.listeners.udp.$name.udp_options</code>

**Env overrides**

 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__UDP_OPTIONS</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__UDP_OPTIONS</code>


**Fields**

- active_n: <code>integer()</code>
  * default: 
  `100`

  Specify the {active, N} option for the socket.
  See: https://erlang.org/doc/man/inet.html#setopts-2

- recbuf: <code>emqx_gateway_schema:bytesize()</code>
  Size of the kernel-space receive buffer for the socket.

- sndbuf: <code>emqx_gateway_schema:bytesize()</code>
  Size of the kernel-space send buffer for the socket.

- buffer: <code>emqx_gateway_schema:bytesize()</code>
  Size of the user-space buffer for the socket.

- reuseaddr: <code>boolean()</code>
  * default: 
  `true`

  Allow local reuse of port numbers.


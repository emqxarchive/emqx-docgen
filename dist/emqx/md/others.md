# Other Configurations

## broker:alarm <a id='broker-alarm'></a>
Settings for the alarms.


**Config paths**

 - <code>alarm</code>

**Env overrides**

 - <code>EMQX_ALARM</code>


**Fields**

- actions: <code>[atom()]</code>
  * default: 
  `[log, publish]`

  The actions triggered when the alarm is activated.<br/>Currently, the following actions are supported: <code>log</code> and <code>publish</code>.
  <code>log</code> is to write the alarm to log (console or file).
  <code>publish</code> is to publish the alarm as an MQTT message to the system topics:
  <code>$SYS/brokers/emqx@xx.xx.xx.x/alarms/activate</code> and
  <code>$SYS/brokers/emqx@xx.xx.xx.x/alarms/deactivate</code>

- size_limit: <code>1..3000</code>
  * default: 
  `1000`

  The maximum total number of deactivated alarms to keep as history.<br/>When this limit is exceeded, the oldest deactivated alarms are deleted to cap the total number.

- validity_period: <code>emqx_schema:duration()</code>
  * default: 
  `"24h"`

  Retention time of deactivated alarms. Alarms are not deleted immediately
  when deactivated, but after the retention time.


## broker <a id='broker'></a>
Message broker options.


**Config paths**

 - <code>broker</code>

**Env overrides**

 - <code>EMQX_BROKER</code>


**Fields**

- enable_session_registry: <code>boolean()</code>
  * default: 
  `true`

  Enable session registry

- session_locking_strategy: <code>local | leader | quorum | all</code>
  * default: 
  `quorum`

  Session locking strategy in a cluster.
    - `local`: only lock the session on the current node
    - `one`: select only one remote node to lock the session
    - `quorum`: select some nodes to lock the session
    - `all`: lock the session on all the nodes in the cluster

- shared_subscription_strategy: <code>random | round_robin | round_robin_per_group | sticky | local | hash_topic | hash_clientid</code>
  * default: 
  `round_robin`

  Dispatch strategy for shared subscription.
    - `random`: dispatch the message to a random selected subscriber
    - `round_robin`: select the subscribers in a round-robin manner
    - `sticky`: always use the last selected subscriber to dispatch, until the subscriber disconnects.
    - `hash`: select the subscribers by the hash of `clientIds`

- shared_dispatch_ack_enabled: <code>boolean()</code>
  * default: 
  `false`

  Enable/disable shared dispatch acknowledgement for QoS 1 and QoS 2 messages.
  This should allow messages to be dispatched to a different subscriber in the group in case the picked (based on `shared_subscription_strategy`) subscriber is offline.

- route_batch_clean: <code>boolean()</code>
  * default: 
  `true`

  Enable batch clean for deleted routes.

- perf: <code>[broker:broker_perf](#broker-broker_perf)</code>


- shared_subscription_group: <code>{$name -> [broker:shared_subscription_group](#broker-shared_subscription_group)}</code>
  Per group dispatch strategy for shared subscription.
  This config is a map from shared subscription group name to the strategy
  name. The group name should be of format `[A-Za-z0-9]`. i.e. no
  special characters are allowed.


## broker:broker_perf <a id='broker-broker_perf'></a>
Broker performance tuning parameters.


**Config paths**

 - <code>broker.perf</code>

**Env overrides**

 - <code>EMQX_BROKER__PERF</code>


**Fields**

- route_lock_type: <code>key | tab | global</code>
  * default: 
  `key`

  Performance tuning for subscribing/unsubscribing a wildcard topic.
  Change this parameter only when there are many wildcard topics.
  NOTE: when changing from/to `global` lock, it requires all nodes in the cluster to be stopped before the change.
    - `key`: mnesia transactional updates with per-key locks. Recommended for a single-node setup.
    - `tab`: mnesia transactional updates with table lock. Recommended for a cluster setup.
    - `global`: updates are protected with a global lock. Recommended for large clusters.

- trie_compaction: <code>boolean()</code>
  * default: 
  `true`

  Enable trie path compaction.
  Enabling it significantly improves wildcard topic subscribe rate, if wildcard topics have unique prefixes like: 'sensor/{{id}}/+/', where ID is unique per subscriber.
  Topic match performance (when publishing) may degrade if messages are mostly published to topics with large number of levels.
  NOTE: This is a cluster-wide configuration. It requires all nodes to be stopped before changing it.


## broker:cache <a id='broker-cache'></a>
Settings for the authorization cache.


**Config paths**

 - <code>authorization.cache</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__CACHE</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable the authorization cache.

- max_size: <code>1..1048576</code>
  * default: 
  `32`

  Maximum number of cached items.

- ttl: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  Time to live for the cached data.  


## broker:conn_congestion <a id='broker-conn_congestion'></a>
Settings for `conn_congestion` alarm.

Sometimes the MQTT connection (usually an MQTT subscriber) may
get "congested", because there are too many packets to be sent.
The socket tries to buffer the packets until the buffer is
full. If more packets arrive after that, the packets will be
"pending" in the queue, and we consider the connection
congested.

Note: `sndbuf` can be set to larger value if the
alarm is triggered too often.
The name of the alarm is of format `conn_congestion/<ClientID>/<Username>`,
where the `<ClientID>` is the client ID of the congested MQTT connection,
and `<Username>` is the username or `unknown_user`.


**Config paths**

 - <code>conn_congestion</code>

**Env overrides**

 - <code>EMQX_CONN_CONGESTION</code>


**Fields**

- enable_alarm: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable connection congestion alarm.

- min_alarm_sustain_duration: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  Minimal time before clearing the alarm.<br/>The alarm is cleared only when there's no pending data in<br/>the queue, and at least <code>min_alarm_sustain_duration</code>milliseconds passed since the last time we considered the connection 'congested'.<br/>This is to avoid clearing and raising the alarm again too often.


## broker:deflate_opts <a id='broker-deflate_opts'></a>
Compression options.


**Config paths**

 - <code>listeners.ws.$name.websocket.deflate_opts</code>
 - <code>listeners.wss.$name.websocket.deflate_opts</code>

**Env overrides**

 - <code>EMQX_LISTENERS__WS__$NAME__WEBSOCKET__DEFLATE_OPTS</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__WEBSOCKET__DEFLATE_OPTS</code>


**Fields**

- level: <code>none | default | best_compression | best_speed</code>
  Compression level. 

- mem_level: <code>1..9</code>
  * default: 
  `8`

  Specifies the size of the compression state.<br/>
  Lower values decrease memory usage per connection.

- strategy: <code>default | filtered | huffman_only | rle</code>
  * default: 
  `default`

  Specifies the compression strategy.

- server_context_takeover: <code>takeover | no_takeover</code>
  * default: 
  `takeover`

  Takeover means the compression state is retained between server messages. 

- client_context_takeover: <code>takeover | no_takeover</code>
  * default: 
  `takeover`

  Takeover means the compression state is retained between client messages. 

- server_max_window_bits: <code>8..15</code>
  * default: 
  `15`

  Specifies the size of the compression context for the server.

- client_max_window_bits: <code>8..15</code>
  * default: 
  `15`

  Specifies the size of the compression context for the client.


## broker:event_names <a id='broker-event_names'></a>
Enable or disable client lifecycle event publishing.

The following options affect MQTT clients as well as
gateway clients. The types of the clients
are distinguished by the topic prefix:

- For the MQTT clients, the format is:
`$SYS/broker/<node>/clients/<clientid>/<event>`
- For the Gateway clients, it is
`$SYS/broker/<node>/gateway/<gateway-name>/clients/<clientid>/<event>`



**Config paths**

 - <code>sys_topics.sys_event_messages</code>

**Env overrides**

 - <code>EMQX_SYS_TOPICS__SYS_EVENT_MESSAGES</code>


**Fields**

- client_connected: <code>boolean()</code>
  * default: 
  `true`

  Enable to publish client connected event messages

- client_disconnected: <code>boolean()</code>
  * default: 
  `true`

  Enable to publish client disconnected event messages.

- client_subscribed: <code>boolean()</code>
  * default: 
  `false`

  Enable to publish event message that client subscribed a topic successfully.

- client_unsubscribed: <code>boolean()</code>
  * default: 
  `false`

  Enable to publish event message that client unsubscribed a topic successfully.


## broker:flapping_detect <a id='broker-flapping_detect'></a>
This config controls the allowed maximum number of `CONNECT` packets received
from the same clientid in a time frame defined by `window_time`.
After the limit is reached, successive `CONNECT` requests are forbidden
(banned) until the end of the time period defined by `ban_time`.


**Config paths**

 - <code>flapping_detect</code>

**Env overrides**

 - <code>EMQX_FLAPPING_DETECT</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable flapping connection detection feature.

- max_count: <code>integer()</code>
  * default: 
  `15`

  The maximum number of disconnects allowed for a MQTT Client in `window_time`

- window_time: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  The time window for flapping detection.

- ban_time: <code>emqx_schema:duration()</code>
  * default: 
  `"5m"`

  How long the flapping clientid will be banned.


## broker:force_gc <a id='broker-force_gc'></a>
Force garbage collection in MQTT connection process after
 they process certain number of messages or bytes of data.


**Config paths**

 - <code>force_gc</code>

**Env overrides**

 - <code>EMQX_FORCE_GC</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable forced garbage collection.

- count: <code>0..inf</code>
  * default: 
  `16000`

  GC the process after this many received messages.

- bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"16MB"`

  GC the process after specified number of bytes have passed through.


## broker:force_shutdown <a id='broker-force_shutdown'></a>
When the process message queue length, or the memory bytes
reaches a certain value, the process is forced to close.

Note: "message queue" here refers to the "message mailbox"
of the Erlang process, not the `mqueue` of QoS 1 and QoS 2.


**Config paths**

 - <code>force_shutdown</code>

**Env overrides**

 - <code>EMQX_FORCE_SHUTDOWN</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable `force_shutdown` feature.

- max_message_queue_len: <code>0..inf</code>
  * default: 
  `1000`

  Maximum message queue length.

- max_heap_size: <code>emqx_schema:wordsize()</code>
  * default: 
  `"32MB"`

  Total heap size


## broker:listener_ssl_opts <a id='broker-listener_ssl_opts'></a>
Socket options for SSL connections.


**Config paths**

 - <code>gateway.exproto.listeners.ssl.$name.ssl_options</code>
 - <code>gateway.stomp.listeners.ssl.$name.ssl_options</code>
 - <code>listeners.ssl.$name.ssl_options</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__SSL_OPTIONS</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__SSL_OPTIONS</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__SSL_OPTIONS</code>


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

- gc_after_handshake: <code>boolean()</code>
  * default: 
  `false`

  Memory usage tuning. If enabled, will immediately perform a garbage collection after
  the TLS/SSL handshake.


## broker:listener_wss_opts <a id='broker-listener_wss_opts'></a>
Socket options for WebSocket/SSL connections.


**Config paths**

 - <code>listeners.wss.$name.ssl_options</code>

**Env overrides**

 - <code>EMQX_LISTENERS__WSS__$NAME__SSL_OPTIONS</code>


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


## broker:listeners <a id='broker-listeners'></a>
MQTT listeners identified by their protocol type and assigned names


**Config paths**

 - <code>listeners</code>

**Env overrides**

 - <code>EMQX_LISTENERS</code>


**Fields**

- tcp: <code>{$name -> [broker:mqtt_tcp_listener](#broker-mqtt_tcp_listener)}</code>
  TCP listeners.

- ssl: <code>{$name -> [broker:mqtt_ssl_listener](#broker-mqtt_ssl_listener)}</code>
  SSL listeners.

- ws: <code>{$name -> [broker:mqtt_ws_listener](#broker-mqtt_ws_listener)}</code>
  HTTP websocket listeners.

- wss: <code>{$name -> [broker:mqtt_wss_listener](#broker-mqtt_wss_listener)}</code>
  HTTPS websocket listeners.

- quic: <code>{$name -> [broker:mqtt_quic_listener](#broker-mqtt_quic_listener)}</code>
  QUIC listeners.


## broker:mqtt <a id='broker-mqtt'></a>
Global MQTT configuration.<br/>The configs here work as default values which can be overridden
in <code>zone</code> configs


**Config paths**

 - <code>mqtt</code>

**Env overrides**

 - <code>EMQX_MQTT</code>


**Fields**

- idle_timeout: <code>infinity | emqx_schema:duration()</code>
  * default: 
  `"15s"`

  After the TCP connection is established, if the MQTT CONNECT packet from the client is not received within the time specified by <code>idle_timeout</code>, the connection will be disconnected.

- max_packet_size: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  Maximum MQTT packet size allowed.

- max_clientid_len: <code>23..65535</code>
  * default: 
  `65535`

  Maximum allowed length of MQTT Client ID.

- max_topic_levels: <code>1..65535</code>
  * default: 
  `128`

  Maximum topic levels allowed.

- max_qos_allowed: <code>qos()</code>
  * default: 
  `2`

  Maximum QoS allowed.

- max_topic_alias: <code>0..65535</code>
  * default: 
  `65535`

  Maximum topic alias, 0 means no topic alias supported.

- retain_available: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable support for MQTT retained message.

- wildcard_subscription: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable support for MQTT wildcard subscription.

- shared_subscription: <code>boolean()</code>
  * default: 
  `true`

  Whether to enable support for MQTT shared subscription.

- exclusive_subscription: <code>boolean()</code>
  * default: 
  `false`

  Whether to enable support for MQTT exclusive subscription.

- ignore_loop_deliver: <code>boolean()</code>
  * default: 
  `false`

  Ignore loop delivery of messages for MQTT v3.1.1/v3.1.0, similar to <code>No Local</code> subscription option in MQTT 5.0.

- strict_mode: <code>boolean()</code>
  * default: 
  `false`

  Parse MQTT messages in strict mode.
  When set to true, invalid utf8 strings in for example client ID, topic name, etc. will cause the client to be disconnected

- response_information: <code>string()</code>
  * default: 
  `""`

  Specify the response information returned to the client. This feature is disabled if is set to "". Applies only to clients using MQTT 5.0.

- server_keepalive: <code>integer() | disabled</code>
  * default: 
  `disabled`

  The keep alive that EMQX requires the client to use. If configured as <code>disabled</code>, it means that the keep alive specified by the client will be used. Requires <code>Server Keep Alive</code> in MQTT 5.0, so it is only applicable to clients using MQTT 5.0 protocol.

- keepalive_backoff: <code>number()</code>
  * default: 
  `0.75`

  The backoff multiplier used by the broker to determine the client keep alive timeout. If EMQX doesn't receive any packet in <code>Keep Alive * Backoff * 2</code> seconds, EMQX will close the current connection.

- max_subscriptions: <code>1..inf | infinity</code>
  * default: 
  `infinity`

  Maximum number of subscriptions allowed per client.

- upgrade_qos: <code>boolean()</code>
  * default: 
  `false`

  Force upgrade of QoS level according to subscription.

- max_inflight: <code>1..65535</code>
  * default: 
  `32`

  Maximum number of QoS 1 and QoS 2 messages that are allowed to be delivered simultaneously before completing the acknowledgment.

- retry_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"30s"`

  Retry interval for QoS 1/2 message delivering.

- max_awaiting_rel: <code>integer() | infinity</code>
  * default: 
  `100`

  For each publisher session, the maximum number of outstanding QoS 2 messages pending on the client to send PUBREL. After reaching this limit, new QoS 2 PUBLISH requests will be rejected with `147(0x93)` until either PUBREL is received or timed out.

- await_rel_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"300s"`

  For client to broker QoS 2 message, the time limit for the broker to wait before the `PUBREL` message is received. The wait is aborted after timed out, meaning the packet ID is freed for new `PUBLISH` requests. Receiving a stale `PUBREL` causes a warning level log. Note, the message is delivered to subscribers before entering the wait for PUBREL.

- session_expiry_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"2h"`

  Specifies how long the session will expire after the connection is disconnected, only for non-MQTT 5.0 connections.

- max_mqueue_len: <code>non_neg_integer() | infinity</code>
  * default: 
  `1000`

  Maximum queue length. Enqueued messages when persistent client disconnected, or inflight window is full.

- mqueue_priorities: <code>map() | disabled</code>
  * default: 
  `disabled`

  Topic priorities. Priority number [1-255]
  There's no priority table by default, hence all messages are treated equal.
  **NOTE**: Comma and equal signs are not allowed for priority topic names.
  **NOTE**: Messages for topics not in the priority table are treated as either highest or lowest priority depending on the configured value for <code>mqtt.mqueue_default_priority</code>.
  **Examples**:
  To configure <code>"topic/1" > "topic/2"</code>:
  <code>mqueue_priorities: {"topic/1": 10, "topic/2": 8}</code>

- mqueue_default_priority: <code>highest | lowest</code>
  * default: 
  `lowest`

  Default topic priority, which will be used by topics not in <code>Topic Priorities</code> (<code>mqueue_priorities</code>).

- mqueue_store_qos0: <code>boolean()</code>
  * default: 
  `true`

  Specifies whether to store QoS 0 messages in the message queue while the connection is down but the session remains.

- use_username_as_clientid: <code>boolean()</code>
  * default: 
  `false`

  Whether to user Client ID as Username.
  This setting takes effect later than <code>Use Peer Certificate as Username</code> (<code>peer_cert_as_username</code>) and <code>Use peer certificate as Client ID</code> (<code>peer_cert_as_clientid</code>).

- peer_cert_as_username: <code>disabled | cn | dn | crt | pem | md5</code>
  * default: 
  `disabled`

  Use the CN, DN field in the peer certificate or the entire certificate content as Username. Only works for the TLS connection.
  Supported configurations are the following:
  - <code>cn</code>: Take the CN field of the certificate as Username
  - <code>dn</code>: Take the DN field of the certificate as Username
  - <code>crt</code>: Take the content of the <code>DER</code> or <code>PEM</code> certificate as Username
  - <code>pem</code>: Convert <code>DER</code> certificate content to <code>PEM</code> format as Username
  - <code>md5</code>: Take the MD5 value of the content of the <code>DER</code> or <code>PEM</code> certificate as Username

- peer_cert_as_clientid: <code>disabled | cn | dn | crt | pem | md5</code>
  * default: 
  `disabled`

  Use the CN, DN field in the peer certificate or the entire certificate content as Client ID. Only works for the TLS connection.
  Supported configurations are the following:
  - <code>cn</code>: Take the CN field of the certificate as Client ID
  - <code>dn</code>: Take the DN field of the certificate as Client ID
  - <code>crt</code>: Take the content of the <code>DER</code> or <code>PEM</code> certificate as Client ID
  - <code>pem</code>: Convert <code>DER</code> certificate content to <code>PEM</code> format as Client ID
  - <code>md5</code>: Take the MD5 value of the content of the <code>DER</code> or <code>PEM</code> certificate as Client ID


## broker:mqtt_quic_listener <a id='broker-mqtt_quic_listener'></a>
Settings for the MQTT over QUIC listener.


**Config paths**

 - <code>listeners.quic.$name</code>

**Env overrides**

 - <code>EMQX_LISTENERS__QUIC__$NAME</code>


**Fields**

- certfile: <code>string()</code>
  Path to the certificate file.

- keyfile: <code>string()</code>
  Path to the secret key file. 

- ciphers: <code>[string()]</code>
  * default: 
  `["TLS_AES_256_GCM_SHA384", "TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"]`

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
  NOTE: QUIC listener supports only 'tlsv1.3' ciphers<br/>

- idle_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `0`

  How long a connection can go idle before it is gracefully shut down. 0 to disable

- handshake_idle_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"10s"`

  How long a handshake can idle before it is discarded. 

- keep_alive_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `0`

  How often to send PING frames to keep a connection alive. 0 means disabled.

- enabled: <code>boolean()</code>
  * default: 
  `true`

  Enable listener. 

- bind: <code>emqx_schema:ip_port() | integer()</code>
  * default: 
  `14567`

  IP address and port for the listening socket.

- acceptors: <code>pos_integer()</code>
  * default: 
  `16`

  The size of the listener's receiving pool.

- max_connections: <code>infinity | pos_integer()</code>
  * default: 
  `infinity`

  The maximum number of concurrent connections allowed by the listener. 

- mountpoint: <code>binary()</code>
  * default: 
  `""`

  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message
  is delivered to the subscriber. The mountpoint is a way that users can use
  to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint`
  set to `some_tenant`, then the client actually subscribes to the topic
  `some_tenant/t`. Similarly, if another client B (connected to the same listener
  as the client A) sends a message to topic `t`, the message is routed
  to all the clients subscribed `some_tenant/t`, so client A will receive the
  message, with topic name `t`.<br/>
  Set to `""` to disable the feature.<br/>
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- zone: <code>atom()</code>
  * default: 
  `default`

  The configuration zone to which the listener belongs.

- limiter: <code>[limiter:listener_fields](#limiter-listener_fields)</code>
  * default: 
  ```
  {
    connection {capacity = 1000, rate = "1000/s"}
  }
  ```

  Type of the rate limit.

- enable_authn: <code>true | false | quick_deny_anonymous</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener, the authentication
  process goes through the configured authentication chain.
  When set to <code>false</code> to allow any clients with or without authentication information such as username or password to log in.
  When set to <code>quick_deny_anonymous</code>, it behaves like when set to <code>true</code> but clients will be
  denied immediately without going through any authenticators if <code>username</code> is not provided. This is useful to fence off
  anonymous clients early.


## broker:mqtt_ssl_listener <a id='broker-mqtt_ssl_listener'></a>
Settings for the MQTT over SSL listener.


**Config paths**

 - <code>listeners.ssl.$name</code>

**Env overrides**

 - <code>EMQX_LISTENERS__SSL__$NAME</code>


**Fields**

- enabled: <code>boolean()</code>
  * default: 
  `true`

  Enable listener. 

- bind: <code>emqx_schema:ip_port() | integer()</code>
  * default: 
  `8883`

  IP address and port for the listening socket.

- acceptors: <code>pos_integer()</code>
  * default: 
  `16`

  The size of the listener's receiving pool.

- max_connections: <code>infinity | pos_integer()</code>
  * default: 
  `infinity`

  The maximum number of concurrent connections allowed by the listener. 

- mountpoint: <code>binary()</code>
  * default: 
  `""`

  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message
  is delivered to the subscriber. The mountpoint is a way that users can use
  to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint`
  set to `some_tenant`, then the client actually subscribes to the topic
  `some_tenant/t`. Similarly, if another client B (connected to the same listener
  as the client A) sends a message to topic `t`, the message is routed
  to all the clients subscribed `some_tenant/t`, so client A will receive the
  message, with topic name `t`.<br/>
  Set to `""` to disable the feature.<br/>
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- zone: <code>atom()</code>
  * default: 
  `default`

  The configuration zone to which the listener belongs.

- limiter: <code>[limiter:listener_fields](#limiter-listener_fields)</code>
  * default: 
  ```
  {
    connection {capacity = 1000, rate = "1000/s"}
  }
  ```

  Type of the rate limit.

- enable_authn: <code>true | false | quick_deny_anonymous</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener, the authentication
  process goes through the configured authentication chain.
  When set to <code>false</code> to allow any clients with or without authentication information such as username or password to log in.
  When set to <code>quick_deny_anonymous</code>, it behaves like when set to <code>true</code> but clients will be
  denied immediately without going through any authenticators if <code>username</code> is not provided. This is useful to fence off
  anonymous clients early.

- access_rules: <code>[string()]</code>
  * default: 
  `["allow all"]`

  The access control rules for this listener.<br/>See: https://github.com/emqtt/esockd#allowdeny

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.<br/>
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"3s"`

  Timeout for proxy protocol. EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- authentication: <code>[[authn-builtin_db:authentication](authn.md#authn-builtin_db-authentication) | [authn-mysql:authentication](authn.md#authn-mysql-authentication) | [authn-postgresql:authentication](authn.md#authn-postgresql-authentication) | [authn-mongodb:standalone](authn.md#authn-mongodb-standalone) | [authn-mongodb:replica-set](authn.md#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](authn.md#authn-mongodb-sharded-cluster) | [authn-redis:standalone](authn.md#authn-redis-standalone) | [authn-redis:cluster](authn.md#authn-redis-cluster) | [authn-redis:sentinel](authn.md#authn-redis-sentinel) | [authn-http:get](authn.md#authn-http-get) | [authn-http:post](authn.md#authn-http-post) | [authn-jwt:hmac-based](authn.md#authn-jwt-hmac-based) | [authn-jwt:public-key](authn.md#authn-jwt-public-key) | [authn-jwt:jwks](authn.md#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](authn.md#authn-scram-builtin_db-authentication)]</code>
  Per-listener authentication override.
  Authentication can be one single authenticator instance or a chain of authenticators as an array.
  When authenticating a login (username, client ID, etc.) the authenticators are checked in the configured order.<br/>

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>


- ssl_options: <code>[broker:listener_ssl_opts](#broker-listener_ssl_opts)</code>



## broker:mqtt_tcp_listener <a id='broker-mqtt_tcp_listener'></a>
Settings for the MQTT over TCP listener.


**Config paths**

 - <code>listeners.tcp.$name</code>

**Env overrides**

 - <code>EMQX_LISTENERS__TCP__$NAME</code>


**Fields**

- enabled: <code>boolean()</code>
  * default: 
  `true`

  Enable listener. 

- bind: <code>emqx_schema:ip_port() | integer()</code>
  * default: 
  `1883`

  IP address and port for the listening socket.

- acceptors: <code>pos_integer()</code>
  * default: 
  `16`

  The size of the listener's receiving pool.

- max_connections: <code>infinity | pos_integer()</code>
  * default: 
  `infinity`

  The maximum number of concurrent connections allowed by the listener. 

- mountpoint: <code>binary()</code>
  * default: 
  `""`

  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message
  is delivered to the subscriber. The mountpoint is a way that users can use
  to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint`
  set to `some_tenant`, then the client actually subscribes to the topic
  `some_tenant/t`. Similarly, if another client B (connected to the same listener
  as the client A) sends a message to topic `t`, the message is routed
  to all the clients subscribed `some_tenant/t`, so client A will receive the
  message, with topic name `t`.<br/>
  Set to `""` to disable the feature.<br/>
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- zone: <code>atom()</code>
  * default: 
  `default`

  The configuration zone to which the listener belongs.

- limiter: <code>[limiter:listener_fields](#limiter-listener_fields)</code>
  * default: 
  ```
  {
    connection {capacity = 1000, rate = "1000/s"}
  }
  ```

  Type of the rate limit.

- enable_authn: <code>true | false | quick_deny_anonymous</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener, the authentication
  process goes through the configured authentication chain.
  When set to <code>false</code> to allow any clients with or without authentication information such as username or password to log in.
  When set to <code>quick_deny_anonymous</code>, it behaves like when set to <code>true</code> but clients will be
  denied immediately without going through any authenticators if <code>username</code> is not provided. This is useful to fence off
  anonymous clients early.

- access_rules: <code>[string()]</code>
  * default: 
  `["allow all"]`

  The access control rules for this listener.<br/>See: https://github.com/emqtt/esockd#allowdeny

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.<br/>
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"3s"`

  Timeout for proxy protocol. EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- authentication: <code>[[authn-builtin_db:authentication](authn.md#authn-builtin_db-authentication) | [authn-mysql:authentication](authn.md#authn-mysql-authentication) | [authn-postgresql:authentication](authn.md#authn-postgresql-authentication) | [authn-mongodb:standalone](authn.md#authn-mongodb-standalone) | [authn-mongodb:replica-set](authn.md#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](authn.md#authn-mongodb-sharded-cluster) | [authn-redis:standalone](authn.md#authn-redis-standalone) | [authn-redis:cluster](authn.md#authn-redis-cluster) | [authn-redis:sentinel](authn.md#authn-redis-sentinel) | [authn-http:get](authn.md#authn-http-get) | [authn-http:post](authn.md#authn-http-post) | [authn-jwt:hmac-based](authn.md#authn-jwt-hmac-based) | [authn-jwt:public-key](authn.md#authn-jwt-public-key) | [authn-jwt:jwks](authn.md#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](authn.md#authn-scram-builtin_db-authentication)]</code>
  Per-listener authentication override.
  Authentication can be one single authenticator instance or a chain of authenticators as an array.
  When authenticating a login (username, client ID, etc.) the authenticators are checked in the configured order.<br/>

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>



## broker:mqtt_ws_listener <a id='broker-mqtt_ws_listener'></a>
Settings for the MQTT over WebSocket listener.


**Config paths**

 - <code>listeners.ws.$name</code>

**Env overrides**

 - <code>EMQX_LISTENERS__WS__$NAME</code>


**Fields**

- enabled: <code>boolean()</code>
  * default: 
  `true`

  Enable listener. 

- bind: <code>emqx_schema:ip_port() | integer()</code>
  * default: 
  `8083`

  IP address and port for the listening socket.

- acceptors: <code>pos_integer()</code>
  * default: 
  `16`

  The size of the listener's receiving pool.

- max_connections: <code>infinity | pos_integer()</code>
  * default: 
  `infinity`

  The maximum number of concurrent connections allowed by the listener. 

- mountpoint: <code>binary()</code>
  * default: 
  `""`

  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message
  is delivered to the subscriber. The mountpoint is a way that users can use
  to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint`
  set to `some_tenant`, then the client actually subscribes to the topic
  `some_tenant/t`. Similarly, if another client B (connected to the same listener
  as the client A) sends a message to topic `t`, the message is routed
  to all the clients subscribed `some_tenant/t`, so client A will receive the
  message, with topic name `t`.<br/>
  Set to `""` to disable the feature.<br/>
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- zone: <code>atom()</code>
  * default: 
  `default`

  The configuration zone to which the listener belongs.

- limiter: <code>[limiter:listener_fields](#limiter-listener_fields)</code>
  * default: 
  ```
  {
    connection {capacity = 1000, rate = "1000/s"}
  }
  ```

  Type of the rate limit.

- enable_authn: <code>true | false | quick_deny_anonymous</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener, the authentication
  process goes through the configured authentication chain.
  When set to <code>false</code> to allow any clients with or without authentication information such as username or password to log in.
  When set to <code>quick_deny_anonymous</code>, it behaves like when set to <code>true</code> but clients will be
  denied immediately without going through any authenticators if <code>username</code> is not provided. This is useful to fence off
  anonymous clients early.

- access_rules: <code>[string()]</code>
  * default: 
  `["allow all"]`

  The access control rules for this listener.<br/>See: https://github.com/emqtt/esockd#allowdeny

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.<br/>
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"3s"`

  Timeout for proxy protocol. EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- authentication: <code>[[authn-builtin_db:authentication](authn.md#authn-builtin_db-authentication) | [authn-mysql:authentication](authn.md#authn-mysql-authentication) | [authn-postgresql:authentication](authn.md#authn-postgresql-authentication) | [authn-mongodb:standalone](authn.md#authn-mongodb-standalone) | [authn-mongodb:replica-set](authn.md#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](authn.md#authn-mongodb-sharded-cluster) | [authn-redis:standalone](authn.md#authn-redis-standalone) | [authn-redis:cluster](authn.md#authn-redis-cluster) | [authn-redis:sentinel](authn.md#authn-redis-sentinel) | [authn-http:get](authn.md#authn-http-get) | [authn-http:post](authn.md#authn-http-post) | [authn-jwt:hmac-based](authn.md#authn-jwt-hmac-based) | [authn-jwt:public-key](authn.md#authn-jwt-public-key) | [authn-jwt:jwks](authn.md#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](authn.md#authn-scram-builtin_db-authentication)]</code>
  Per-listener authentication override.
  Authentication can be one single authenticator instance or a chain of authenticators as an array.
  When authenticating a login (username, client ID, etc.) the authenticators are checked in the configured order.<br/>

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>


- websocket: <code>[broker:ws_opts](#broker-ws_opts)</code>



## broker:mqtt_wss_listener <a id='broker-mqtt_wss_listener'></a>
Settings for the MQTT over WebSocket/SSL listener.


**Config paths**

 - <code>listeners.wss.$name</code>

**Env overrides**

 - <code>EMQX_LISTENERS__WSS__$NAME</code>


**Fields**

- enabled: <code>boolean()</code>
  * default: 
  `true`

  Enable listener. 

- bind: <code>emqx_schema:ip_port() | integer()</code>
  * default: 
  `8084`

  IP address and port for the listening socket.

- acceptors: <code>pos_integer()</code>
  * default: 
  `16`

  The size of the listener's receiving pool.

- max_connections: <code>infinity | pos_integer()</code>
  * default: 
  `infinity`

  The maximum number of concurrent connections allowed by the listener. 

- mountpoint: <code>binary()</code>
  * default: 
  `""`

  When publishing or subscribing, prefix all topics with a mountpoint string.
  The prefixed string will be removed from the topic name when the message
  is delivered to the subscriber. The mountpoint is a way that users can use
  to implement isolation of message routing between different listeners.
  For example if a client A subscribes to `t` with `listeners.tcp.\<name>.mountpoint`
  set to `some_tenant`, then the client actually subscribes to the topic
  `some_tenant/t`. Similarly, if another client B (connected to the same listener
  as the client A) sends a message to topic `t`, the message is routed
  to all the clients subscribed `some_tenant/t`, so client A will receive the
  message, with topic name `t`.<br/>
  Set to `""` to disable the feature.<br/>
  Variables in mountpoint string:
    - <code>${clientid}</code>: clientid
    - <code>${username}</code>: username

- zone: <code>atom()</code>
  * default: 
  `default`

  The configuration zone to which the listener belongs.

- limiter: <code>[limiter:listener_fields](#limiter-listener_fields)</code>
  * default: 
  ```
  {
    connection {capacity = 1000, rate = "1000/s"}
  }
  ```

  Type of the rate limit.

- enable_authn: <code>true | false | quick_deny_anonymous</code>
  * default: 
  `true`

  Set <code>true</code> (default) to enable client authentication on this listener, the authentication
  process goes through the configured authentication chain.
  When set to <code>false</code> to allow any clients with or without authentication information such as username or password to log in.
  When set to <code>quick_deny_anonymous</code>, it behaves like when set to <code>true</code> but clients will be
  denied immediately without going through any authenticators if <code>username</code> is not provided. This is useful to fence off
  anonymous clients early.

- access_rules: <code>[string()]</code>
  * default: 
  `["allow all"]`

  The access control rules for this listener.<br/>See: https://github.com/emqtt/esockd#allowdeny

- proxy_protocol: <code>boolean()</code>
  * default: 
  `false`

  Enable the Proxy Protocol V1/2 if the EMQX cluster is deployed behind HAProxy or Nginx.<br/>
  See: https://www.haproxy.com/blog/haproxy/proxy-protocol/

- proxy_protocol_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"3s"`

  Timeout for proxy protocol. EMQX will close the TCP connection if proxy protocol packet is not received within the timeout.

- authentication: <code>[[authn-builtin_db:authentication](authn.md#authn-builtin_db-authentication) | [authn-mysql:authentication](authn.md#authn-mysql-authentication) | [authn-postgresql:authentication](authn.md#authn-postgresql-authentication) | [authn-mongodb:standalone](authn.md#authn-mongodb-standalone) | [authn-mongodb:replica-set](authn.md#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](authn.md#authn-mongodb-sharded-cluster) | [authn-redis:standalone](authn.md#authn-redis-standalone) | [authn-redis:cluster](authn.md#authn-redis-cluster) | [authn-redis:sentinel](authn.md#authn-redis-sentinel) | [authn-http:get](authn.md#authn-http-get) | [authn-http:post](authn.md#authn-http-post) | [authn-jwt:hmac-based](authn.md#authn-jwt-hmac-based) | [authn-jwt:public-key](authn.md#authn-jwt-public-key) | [authn-jwt:jwks](authn.md#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](authn.md#authn-scram-builtin_db-authentication)]</code>
  Per-listener authentication override.
  Authentication can be one single authenticator instance or a chain of authenticators as an array.
  When authenticating a login (username, client ID, etc.) the authenticators are checked in the configured order.<br/>

- tcp_options: <code>[broker:tcp_opts](#broker-tcp_opts)</code>


- ssl_options: <code>[broker:listener_wss_opts](#broker-listener_wss_opts)</code>


- websocket: <code>[broker:ws_opts](#broker-ws_opts)</code>



## broker:overload_protection <a id='broker-overload_protection'></a>
Overload protection mechanism monitors the load of the system and temporarily
disables some features (such as accepting new connections) when the load is high.


**Config paths**

 - <code>overload_protection</code>

**Env overrides**

 - <code>EMQX_OVERLOAD_PROTECTION</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  React on system overload or not.

- backoff_delay: <code>0..inf</code>
  * default: 
  `1`

  When at high load, some unimportant tasks could be delayed for execution, here set the duration in milliseconds precision.

- backoff_gc: <code>boolean()</code>
  * default: 
  `false`

  When at high load, skip forceful GC.

- backoff_hibernation: <code>boolean()</code>
  * default: 
  `true`

  When at high load, skip process hibernation.

- backoff_new_conn: <code>boolean()</code>
  * default: 
  `true`

  When at high load, close new incoming connections.


## broker:persistent_session_builtin <a id='broker-persistent_session_builtin'></a>
Settings for the built-in storage engine of persistent messages.


**Config paths**

 - <code>persistent_session_store.backend</code>

**Env overrides**

 - <code>EMQX_PERSISTENT_SESSION_STORE__BACKEND</code>


**Fields**

- type: <code>builtin</code>
  * default: 
  `builtin`



- session: <code>[broker:persistent_table_mria_opts](#broker-persistent_table_mria_opts)</code>
  Performance tuning options for built-in session table.

- session_messages: <code>[broker:persistent_table_mria_opts](#broker-persistent_table_mria_opts)</code>
  Performance tuning options for built-in session messages table.

- messages: <code>[broker:persistent_table_mria_opts](#broker-persistent_table_mria_opts)</code>
  Performance tuning options for built-in messages table.


## broker:persistent_session_store <a id='broker-persistent_session_store'></a>
Settings for message persistence.


**Config paths**

 - <code>persistent_session_store</code>

**Env overrides**

 - <code>EMQX_PERSISTENT_SESSION_STORE</code>


**Fields**

- enabled: <code>boolean()</code>
  * default: 
  `false`

  Use the database to store information about persistent sessions.
  This makes it possible to migrate a client connection to another
  cluster node if a node is stopped.

- on_disc: <code>boolean()</code>
  * default: 
  `true`

  Save information about the persistent sessions on disc.
  If this option is enabled, persistent sessions will survive full restart of the cluster.
  Otherwise, all the data will be stored in RAM, and it will be lost when all the nodes in the cluster are stopped.

- ram_cache: <code>boolean()</code>
  * default: 
  `false`

  Maintain a copy of the data in RAM for faster access.

- backend: <code>[broker:persistent_session_builtin](#broker-persistent_session_builtin)</code>
  * default: 
  ```
  {
    messages {ram_cache = "false"}
    session {ram_cache = "true"}
    session_messages {ram_cache = "true"}
    type = "builtin"
  }
  ```

  Database management system used to store information about persistent sessions and messages.
  - `builtin`: Use the embedded database (mria)

- max_retain_undelivered: <code>emqx_schema:duration()</code>
  * default: 
  `"1h"`

  The time messages that was not delivered to a persistent session
  is stored before being garbage collected if the node the previous
  session was handled on restarts of is stopped.

- message_gc_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"1h"`

  The starting interval for garbage collection of undelivered messages to
  a persistent session. This affects how often the "max_retain_undelivered"
  is checked for removal.

- session_message_gc_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  The starting interval for garbage collection of transient data for
  persistent session messages. This does not affect the lifetime length
  of persistent session messages.


## broker:persistent_table_mria_opts <a id='broker-persistent_table_mria_opts'></a>
Tuning options for the mria table.


**Config paths**

 - <code>persistent_session_store.backend.messages</code>
 - <code>persistent_session_store.backend.session</code>
 - <code>persistent_session_store.backend.session_messages</code>

**Env overrides**

 - <code>EMQX_PERSISTENT_SESSION_STORE__BACKEND__MESSAGES</code>
 - <code>EMQX_PERSISTENT_SESSION_STORE__BACKEND__SESSION</code>
 - <code>EMQX_PERSISTENT_SESSION_STORE__BACKEND__SESSION_MESSAGES</code>


**Fields**

- ram_cache: <code>boolean()</code>
  * default: 
  `true`

  Maintain a copy of the data in RAM for faster access.


## broker:shared_subscription_group <a id='broker-shared_subscription_group'></a>
Per group dispatch strategy for shared subscription


**Config paths**

 - <code>broker.shared_subscription_group.$name</code>

**Env overrides**

 - <code>EMQX_BROKER__SHARED_SUBSCRIPTION_GROUP__$NAME</code>


**Fields**

- strategy: <code>random | round_robin | round_robin_per_group | sticky | local | hash_topic | hash_clientid</code>
  * default: 
  `random`

  Dispatch strategy for shared subscription.
  - `random`: dispatch the message to a random selected subscriber
  - `round_robin`: select the subscribers in a round-robin manner
  - `round_robin_per_group`: select the subscribers in round-robin fashion within each shared subscriber group
  - `sticky`: always use the last selected subscriber to dispatch,
  until the subscriber disconnects.
  - `hash`: select the subscribers by the hash of `clientIds`
  - `local`: send to a random local subscriber. If local
  subscriber was not found, send to a random subscriber cluster-wide


## broker:ssl_client_opts <a id='broker-ssl_client_opts'></a>
Socket options for SSL clients.


**Config paths**

 - <code>authentication.$INDEX.ssl</code>
 - <code>authorization.sources.$INDEX.ssl</code>
 - <code>bridges.mqtt.$name.ssl</code>
 - <code>bridges.webhook.$name.ssl</code>
 - <code>cluster.etcd.ssl</code>
 - <code>gateway.coap.authentication.ssl</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.ssl</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.ssl</code>
 - <code>gateway.exproto.authentication.ssl</code>
 - <code>gateway.exproto.handler.ssl_options</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.ssl</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.ssl</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.ssl</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.ssl</code>
 - <code>gateway.lwm2m.authentication.ssl</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.ssl</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.ssl</code>
 - <code>gateway.mqttsn.authentication.ssl</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.ssl</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.ssl</code>
 - <code>gateway.stomp.authentication.ssl</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.ssl</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.ssl</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.ssl</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.ssl</code>
 - <code>listeners.ws.$name.authentication.$INDEX.ssl</code>
 - <code>listeners.wss.$name.authentication.$INDEX.ssl</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__SSL</code>
 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX__SSL</code>
 - <code>EMQX_BRIDGES__MQTT__$NAME__SSL</code>
 - <code>EMQX_BRIDGES__WEBHOOK__$NAME__SSL</code>
 - <code>EMQX_CLUSTER__ETCD__SSL</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__EXPROTO__HANDLER__SSL_OPTIONS</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__SSL</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__SSL</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__SSL</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__SSL</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__SSL</code>


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

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable TLS. 

- server_name_indication: <code>disable | string()</code>
  Specify the host name to be used in TLS Server Name Indication extension.<br/>
  For instance, when connecting to "server.example.net", the genuine server
  which accepts the connection and performs TLS handshake may differ from the
  host the TLS client initially connects to, e.g. when connecting to an IP address
  or when the host has multiple resolvable DNS records <br/>
  If not specified, it will default to the host name string which is used
  to establish the connection, unless it is IP addressed used.<br/>
  The host name is then also used in the host name verification of the peer
  certificate.<br/> The special value 'disable' prevents the Server Name
  Indication extension from being sent and disables the hostname
  verification check.


## broker:stats <a id='broker-stats'></a>
Enable/disable statistic data collection.
Statistic data such as message receive/send count/rate etc. It provides insights of system performance and helps to diagnose issues. You can find statistic data from the dashboard, or from the '/stats' API.


**Config paths**

 - <code>stats</code>

**Env overrides**

 - <code>EMQX_STATS</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable/disable statistic data collection.


## broker:sys_topics <a id='broker-sys_topics'></a>
The EMQX Broker periodically publishes its own status, message statistics,
client online and offline events to the system topic starting with `$SYS/`.

The following options control the behavior of `$SYS` topics.


**Config paths**

 - <code>sys_topics</code>

**Env overrides**

 - <code>EMQX_SYS_TOPICS</code>


**Fields**

- sys_msg_interval: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `"1m"`

  Time interval of publishing `$SYS` messages.

- sys_heartbeat_interval: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `"30s"`

  Time interval for publishing following heartbeat messages:
    - `$SYS/brokers/<node>/uptime`
    - `$SYS/brokers/<node>/datetime`

- sys_event_messages: <code>[broker:event_names](#broker-event_names)</code>
  Client events messages.


## broker:sysmon <a id='broker-sysmon'></a>
Features related to system monitoring and introspection.


**Config paths**

 - <code>sysmon</code>

**Env overrides**

 - <code>EMQX_SYSMON</code>


**Fields**

- vm: <code>[broker:sysmon_vm](#broker-sysmon_vm)</code>


- os: <code>[broker:sysmon_os](#broker-sysmon_os)</code>


- top: <code>[broker:sysmon_top](#broker-sysmon_top)</code>



## broker:sysmon_os <a id='broker-sysmon_os'></a>
This part of the configuration is responsible for monitoring
 the host OS health, such as free memory, disk space, CPU load, etc.


**Config paths**

 - <code>sysmon.os</code>

**Env overrides**

 - <code>EMQX_SYSMON__OS</code>


**Fields**

- cpu_check_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"60s"`

  The time interval for the periodic CPU check.

- cpu_high_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"80%"`

  The threshold, as percentage of system CPU load,
   for how much system cpu can be used before the corresponding alarm is raised.

- cpu_low_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"60%"`

  The threshold, as percentage of system CPU load,
   for how much system cpu can be used before the corresponding alarm is cleared.

- mem_check_interval: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `"60s"`

  The time interval for the periodic memory check.

- sysmem_high_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"70%"`

  The threshold, as percentage of system memory,
   for how much system memory can be allocated before the corresponding alarm is raised.

- procmem_high_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"5%"`

  The threshold, as percentage of system memory,
   for how much system memory can be allocated by one Erlang process before
   the corresponding alarm is raised.


## broker:sysmon_top <a id='broker-sysmon_top'></a>
This part of the configuration is responsible for monitoring
 the Erlang processes in the VM. This information can be sent to an external
 PostgreSQL database. This feature is inactive unless the PostgreSQL sink is configured.


**Config paths**

 - <code>sysmon.top</code>

**Env overrides**

 - <code>EMQX_SYSMON__TOP</code>


**Fields**

- num_items: <code>non_neg_integer()</code>
  * default: 
  `10`

  * mapping: 
  `system_monitor.top_num_items`

  The number of top processes per monitoring group

- sample_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"2s"`

  * mapping: 
  `system_monitor.top_sample_interval`

  Specifies how often process top should be collected

- max_procs: <code>non_neg_integer()</code>
  * default: 
  `1000000`

  * mapping: 
  `system_monitor.top_max_procs`

  Stop collecting data when the number of processes
  in the VM exceeds this value

- db_hostname: <code>string()</code>
  * default: 
  `[]`

  * mapping: 
  `system_monitor.db_hostname`

  Hostname of the PostgreSQL database that collects the data points

- db_port: <code>integer()</code>
  * default: 
  `5432`

  * mapping: 
  `system_monitor.db_port`

  Port of the PostgreSQL database that collects the data points.

- db_username: <code>string()</code>
  * default: 
  `"system_monitor"`

  * mapping: 
  `system_monitor.db_username`

  Username of the PostgreSQL database

- db_password: <code>binary()</code>
  * default: 
  `"system_monitor_password"`

  * mapping: 
  `system_monitor.db_password`

  EMQX user password in the PostgreSQL database

- db_name: <code>string()</code>
  * default: 
  `"postgres"`

  * mapping: 
  `system_monitor.db_name`

  PostgreSQL database name


## broker:sysmon_vm <a id='broker-sysmon_vm'></a>
This part of the configuration is responsible for collecting
 BEAM VM events, such as long garbage collection, traffic congestion in the inter-broker
 communication, etc.


**Config paths**

 - <code>sysmon.vm</code>

**Env overrides**

 - <code>EMQX_SYSMON__VM</code>


**Fields**

- process_check_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"30s"`

  The time interval for the periodic process limit check.

- process_high_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"80%"`

  The threshold, as percentage of processes, for how many
   processes can simultaneously exist at the local node before the corresponding
   alarm is raised.

- process_low_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"60%"`

  The threshold, as percentage of processes, for how many
   processes can simultaneously exist at the local node before the corresponding
   alarm is cleared.

- long_gc: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `disabled`

  Enable Long GC monitoring.

- long_schedule: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `"240ms"`

  Enable Long Schedule monitoring.

- large_heap: <code>disabled | emqx_schema:bytesize()</code>
  * default: 
  `"32MB"`

  Enable Large Heap monitoring.

- busy_dist_port: <code>boolean()</code>
  * default: 
  `true`

  Enable Busy Distribution Port monitoring.

- busy_port: <code>boolean()</code>
  * default: 
  `true`

  Enable Busy Port monitoring.


## broker:tcp_opts <a id='broker-tcp_opts'></a>
TCP listener options.


**Config paths**

 - <code>gateway.exproto.listeners.ssl.$name.tcp_options</code>
 - <code>gateway.exproto.listeners.tcp.$name.tcp_options</code>
 - <code>gateway.stomp.listeners.ssl.$name.tcp_options</code>
 - <code>gateway.stomp.listeners.tcp.$name.tcp_options</code>
 - <code>listeners.ssl.$name.tcp_options</code>
 - <code>listeners.tcp.$name.tcp_options</code>
 - <code>listeners.ws.$name.tcp_options</code>
 - <code>listeners.wss.$name.tcp_options</code>

**Env overrides**

 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_LISTENERS__WS__$NAME__TCP_OPTIONS</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__TCP_OPTIONS</code>


**Fields**

- active_n: <code>integer()</code>
  * default: 
  `100`

  Specify the {active, N} option for this Socket.<br/>
  See: https://erlang.org/doc/man/inet.html#setopts-2

- backlog: <code>pos_integer()</code>
  * default: 
  `1024`

  TCP backlog defines the maximum length that the queue of
   pending connections can grow to.

- send_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"15s"`

  The TCP send timeout for the connections. 

- send_timeout_close: <code>boolean()</code>
  * default: 
  `true`

  Close the connection if send timeout.

- recbuf: <code>emqx_schema:bytesize()</code>
  The TCP receive buffer (OS kernel) for the connections.

- sndbuf: <code>emqx_schema:bytesize()</code>
  The TCP send buffer (OS kernel) for the connections.

- buffer: <code>emqx_schema:bytesize()</code>
  * default: 
  `"4KB"`

  The size of the user-space buffer used by the driver.

- high_watermark: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  The socket is set to a busy state when the amount of data queued internally
    by the VM socket implementation reaches this limit.

- nodelay: <code>boolean()</code>
  * default: 
  `true`

  The TCP_NODELAY flag for the connections.

- reuseaddr: <code>boolean()</code>
  * default: 
  `true`

  The SO_REUSEADDR flag for the connections.


## broker:trace <a id='broker-trace'></a>
Real-time filtering logs for the ClientID or Topic or IP for debugging.


**Config paths**

 - <code>trace</code>

**Env overrides**

 - <code>EMQX_TRACE</code>


**Fields**

- payload_encode: <code>hex | text | hidden</code>
  * default: 
  `text`

  Determine the format of the payload format in the trace file.<br/>
  `text`: Text-based protocol or plain text protocol.
   It is recommended when payload is JSON encoded.<br/>
  `hex`: Binary hexadecimal encode. It is recommended when payload is a custom binary protocol.<br/>
  `hidden`: payload is obfuscated as `******`


## broker:ws_opts <a id='broker-ws_opts'></a>
WebSocket listener options.


**Config paths**

 - <code>listeners.ws.$name.websocket</code>
 - <code>listeners.wss.$name.websocket</code>

**Env overrides**

 - <code>EMQX_LISTENERS__WS__$NAME__WEBSOCKET</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__WEBSOCKET</code>


**Fields**

- mqtt_path: <code>string()</code>
  * default: 
  `"/mqtt"`

  WebSocket's MQTT protocol path. So the address of EMQX Broker's WebSocket is:
  <code>ws://{ip}:{port}/mqtt</code>

- mqtt_piggyback: <code>single | multiple</code>
  * default: 
  `multiple`

  Whether a WebSocket message is allowed to contain multiple MQTT packets.

- compress: <code>boolean()</code>
  * default: 
  `false`

  If <code>true</code>, compress WebSocket messages using <code>zlib</code>.<br/>
  The configuration items under <code>deflate_opts</code> belong to the compression-related parameter configuration.

- idle_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"7200s"`

  Close transport-layer connections from the clients that have not sent MQTT CONNECT
  message within this interval.

- max_frame_size: <code>infinity | integer()</code>
  * default: 
  `infinity`

  The maximum length of a single MQTT packet.

- fail_if_no_subprotocol: <code>boolean()</code>
  * default: 
  `true`

  If <code>true</code>, the server will return an error when
   the client does not carry the <code>Sec-WebSocket-Protocol</code> field.
   <br/>Note: WeChat applet needs to disable this verification.

- supported_subprotocols: <code>emqx_schema:comma_separated_list()</code>
  * default: 
  `"mqtt, mqtt-v3, mqtt-v3.1.1, mqtt-v5"`

  Comma-separated list of supported subprotocols.

- check_origin_enable: <code>boolean()</code>
  * default: 
  `false`

  If <code>true</code>, <code>origin</code> HTTP header will be
   validated against the list of allowed origins configured in <code>check_origins</code>
   parameter.

- allow_origin_absence: <code>boolean()</code>
  * default: 
  `true`

  If <code>false</code> and <code>check_origin_enable</code> is
   <code>true</code>, the server will reject requests that don't have <code>origin</code>
   HTTP header.

- check_origins: <code>emqx_schema:comma_separated_binary()</code>
  * default: 
  `"http://localhost:18083, http://127.0.0.1:18083"`

  List of allowed origins.<br/>See <code>check_origin_enable</code>.

- proxy_address_header: <code>string()</code>
  * default: 
  `"x-forwarded-for"`

  HTTP header used to pass information about the client IP address.
  Relevant when the EMQX cluster is deployed behind a load-balancer.

- proxy_port_header: <code>string()</code>
  * default: 
  `"x-forwarded-port"`

  HTTP header used to pass information about the client port.
  Relevant when the EMQX cluster is deployed behind a load-balancer.

- deflate_opts: <code>[broker:deflate_opts](#broker-deflate_opts)</code>



## broker:zone <a id='broker-zone'></a>
A `Zone` defines a set of configuration items (such as the maximum number of connections) that can be shared between multiple listeners.

`Listener` can refer to a `Zone` through the configuration item <code>listener.\<Protocol>.\<Listener Name>.zone</code>.

The configs defined in the zones will override the global configs with the same key.

For example, given the following config:
```
a {
    b: 1, c: 1
}
zone.my_zone {
  a {
    b:2
  }
}
```

The global config `a` is overridden by the configs `a` inside the zone `my_zone`.

If there is a listener using the zone `my_zone`, the value of config `a` will be: `{b:2, c: 1}`.
Note that although the default value of `a.c` is `0`, the global value is used, i.e. configs in the zone have no default values. To override `a.c` one must configure it explicitly in the zone.

All the global configs that can be overridden in zones are:
 - `stats.*`
 - `mqtt.*`
 - `authorization.*`
 - `flapping_detect.*`
 - `force_shutdown.*`
 - `conn_congestion.*`
 - `force_gc.*`




**Config paths**

 - <code>zones.$name</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME</code>


**Fields**

- mqtt: <code>[zone:mqtt](#zone-mqtt)</code>


- stats: <code>[zone:stats](#zone-stats)</code>


- flapping_detect: <code>[zone:flapping_detect](#zone-flapping_detect)</code>


- force_shutdown: <code>[zone:force_shutdown](#zone-force_shutdown)</code>


- conn_congestion: <code>[zone:conn_congestion](#zone-conn_congestion)</code>


- force_gc: <code>[zone:force_gc](#zone-force_gc)</code>


- overload_protection: <code>[zone:overload_protection](#zone-overload_protection)</code>



## dashboard <a id='dashboard'></a>
Configuration for EMQX dashboard.


**Config paths**

 - <code>dashboard</code>

**Env overrides**

 - <code>EMQX_DASHBOARD</code>


**Fields**

- listeners: <code>[dashboard:listeners](#dashboard-listeners)</code>
  HTTP(s) listeners are identified by their protocol type and are
  used to serve dashboard UI and restful HTTP API.
  Listeners must have a unique combination of port number and IP address.
  For example, an HTTP listener can listen on all configured IP addresses
  on a given port for a machine by specifying the IP address 0.0.0.0.
  Alternatively, the HTTP listener can specify a unique IP address for each listener,
  but use the same port.

- default_username: <code>binary()</code>
  * default: 
  `"admin"`

  The default username of the automatically created dashboard user.

- default_password: <code>binary()</code>
  * default: 
  `"public"`

  The initial default password for dashboard 'admin' user.
  For safety, it should be changed as soon as possible.

- sample_interval: <code>emqx_schema:duration_s()</code>
  * default: 
  `"10s"`

  How often to update metrics displayed in the dashboard.
  Note: `sample_interval` should be a divisor of 60.

- token_expired_time: <code>emqx_schema:duration()</code>
  * default: 
  `"60m"`

  JWT token expiration time.

- cors: <code>boolean()</code>
  * default: 
  `false`

  Support Cross-Origin Resource Sharing (CORS).
  Allows a server to indicate any origins (domain, scheme, or port) other than
  its own from which a browser should permit loading resources.

- i18n_lang: <code>en | zh</code>
  * default: 
  `en`

  Internationalization language support.

- bootstrap_users_file: <code>binary()</code>
  Initialize users file.


## dashboard:http <a id='dashboard-http'></a>
Configuration for the dashboard listener (plaintext).


**Config paths**

 - <code>dashboard.listeners.http</code>

**Env overrides**

 - <code>EMQX_DASHBOARD__LISTENERS__HTTP</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Ignore or enable this listener

- bind: <code>non_neg_integer() | emqx_schema:ip_port()</code>
  * default: 
  `18083`

  Port without IP(18083) or port with specified IP(127.0.0.1:18083).

- num_acceptors: <code>integer()</code>
  * default: 
  `4`

  Socket acceptor pool size for TCP protocols.

- max_connections: <code>integer()</code>
  * default: 
  `512`

  Maximum number of simultaneous connections.

- backlog: <code>integer()</code>
  * default: 
  `1024`

  Defines the maximum length that the queue of pending connections can grow to.

- send_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  Send timeout for the socket.

- inet6: <code>boolean()</code>
  * default: 
  `false`

  Enable IPv6 support, default is false, which means IPv4 only.

- ipv6_v6only: <code>boolean()</code>
  * default: 
  `false`

  Disable IPv4-to-IPv6 mapping for the listener.


## dashboard:https <a id='dashboard-https'></a>
Configuration for the dashboard listener (TLS).


**Config paths**

 - <code>dashboard.listeners.https</code>

**Env overrides**

 - <code>EMQX_DASHBOARD__LISTENERS__HTTPS</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Ignore or enable this listener

- bind: <code>non_neg_integer() | emqx_schema:ip_port()</code>
  * default: 
  `18084`

  Port without IP(18083) or port with specified IP(127.0.0.1:18083).

- num_acceptors: <code>integer()</code>
  * default: 
  `4`

  Socket acceptor pool size for TCP protocols.

- max_connections: <code>integer()</code>
  * default: 
  `512`

  Maximum number of simultaneous connections.

- backlog: <code>integer()</code>
  * default: 
  `1024`

  Defines the maximum length that the queue of pending connections can grow to.

- send_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  Send timeout for the socket.

- inet6: <code>boolean()</code>
  * default: 
  `false`

  Enable IPv6 support, default is false, which means IPv4 only.

- ipv6_v6only: <code>boolean()</code>
  * default: 
  `false`

  Disable IPv4-to-IPv6 mapping for the listener.

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


## dashboard:listeners <a id='dashboard-listeners'></a>
Configuration for the dashboard listener.


**Config paths**

 - <code>dashboard.listeners</code>

**Env overrides**

 - <code>EMQX_DASHBOARD__LISTENERS</code>


**Fields**

- http: <code>[dashboard:http](#dashboard-http)</code>
  TCP listeners

- https: <code>[dashboard:https](#dashboard-https)</code>
  SSL listeners


## exhook <a id='exhook'></a>
External hook (exhook) configuration.


**Config paths**

 - <code>exhook</code>

**Env overrides**

 - <code>EMQX_EXHOOK</code>


**Fields**

- servers: <code>[[exhook:server](#exhook-server)]</code>
  * default: 
  `[]`

  List of exhook servers


## exhook:server <a id='exhook-server'></a>
gRPC server configuration.


**Config paths**

 - <code>exhook.servers.$INDEX</code>

**Env overrides**

 - <code>EMQX_EXHOOK__SERVERS__$INDEX</code>


**Fields**

- name: <code>binary()</code>
  Name of the exhook server

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable this Exhook server

- url: <code>binary()</code>
  URL of the gRPC server

- request_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  The timeout of request gRPC server

- failed_action: <code>deny | ignore</code>
  * default: 
  `deny`

  The value that is returned when the request to the gRPC server fails for any reason

- ssl: <code>[exhook:ssl_conf](#exhook-ssl_conf)</code>


- socket_options: <code>[exhook:socket_options](#exhook-socket_options)</code>
  * default: 
  `{keepalive = true, nodelay = true}`



- auto_reconnect: <code>false | emqx_schema:duration()</code>
  * default: 
  `"60s"`

  Whether to automatically reconnect (initialize) the gRPC server.
  When gRPC is not available, Exhook tries to request the gRPC service at that interval and reinitialize the list of mounted hooks.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  The process pool size for gRPC client


## exhook:socket_options <a id='exhook-socket_options'></a>
Connection socket options


**Config paths**

 - <code>exhook.servers.$INDEX.socket_options</code>

**Env overrides**

 - <code>EMQX_EXHOOK__SERVERS__$INDEX__SOCKET_OPTIONS</code>


**Fields**

- keepalive: <code>boolean()</code>
  * default: 
  `true`

  Enables/disables periodic transmission on a connected socket when no other data is exchanged.
  If the other end does not respond, the connection is considered broken and an error message is sent to the controlling process.

- nodelay: <code>boolean()</code>
  * default: 
  `true`

  If true, option TCP_NODELAY is turned on for the socket,
  which means that also small amounts of data are sent immediately

- recbuf: <code>emqx_schema:bytesize()</code>
  The minimum size of receive buffer to use for the socket

- sndbuf: <code>emqx_schema:bytesize()</code>
  The minimum size of send buffer to use for the socket


## exhook:ssl_conf <a id='exhook-ssl_conf'></a>
SSL client configuration.


**Config paths**

 - <code>exhook.servers.$INDEX.ssl</code>

**Env overrides**

 - <code>EMQX_EXHOOK__SERVERS__$INDEX__SSL</code>


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

- secure_renegotiate: <code>boolean()</code>
  * default: 
  `true`

  SSL parameter renegotiation is a feature that allows a client and a server
  to renegotiate the parameters of the SSL connection on the fly.
  RFC 5746 defines a more secure way of doing this. By enabling secure renegotiation,
  you drop support for the insecure renegotiation, prone to MitM attacks.

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable TLS. 

- server_name_indication: <code>disable | string()</code>
  Specify the host name to be used in TLS Server Name Indication extension.<br/>
  For instance, when connecting to "server.example.net", the genuine server
  which accepts the connection and performs TLS handshake may differ from the
  host the TLS client initially connects to, e.g. when connecting to an IP address
  or when the host has multiple resolvable DNS records <br/>
  If not specified, it will default to the host name string which is used
  to establish the connection, unless it is IP addressed used.<br/>
  The host name is then also used in the host name verification of the peer
  certificate.<br/> The special value 'disable' prevents the Server Name
  Indication extension from being sent and disables the hostname
  verification check.


## limiter:bucket_opts <a id='limiter-bucket_opts'></a>
Settings for the bucket.


**Config paths**

 - <code>listeners.quic.$name.limiter.bytes_in</code>
 - <code>listeners.quic.$name.limiter.connection</code>
 - <code>listeners.quic.$name.limiter.message_in</code>
 - <code>listeners.quic.$name.limiter.message_routing</code>
 - <code>listeners.ssl.$name.limiter.bytes_in</code>
 - <code>listeners.ssl.$name.limiter.connection</code>
 - <code>listeners.ssl.$name.limiter.message_in</code>
 - <code>listeners.ssl.$name.limiter.message_routing</code>
 - <code>listeners.tcp.$name.limiter.bytes_in</code>
 - <code>listeners.tcp.$name.limiter.connection</code>
 - <code>listeners.tcp.$name.limiter.message_in</code>
 - <code>listeners.tcp.$name.limiter.message_routing</code>
 - <code>listeners.ws.$name.limiter.bytes_in</code>
 - <code>listeners.ws.$name.limiter.connection</code>
 - <code>listeners.ws.$name.limiter.message_in</code>
 - <code>listeners.ws.$name.limiter.message_routing</code>
 - <code>listeners.wss.$name.limiter.bytes_in</code>
 - <code>listeners.wss.$name.limiter.connection</code>
 - <code>listeners.wss.$name.limiter.message_in</code>
 - <code>listeners.wss.$name.limiter.message_routing</code>

**Env overrides**

 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__BYTES_IN</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CONNECTION</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__BYTES_IN</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CONNECTION</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__BYTES_IN</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CONNECTION</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__BYTES_IN</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CONNECTION</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__BYTES_IN</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CONNECTION</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__MESSAGE_ROUTING</code>


**Fields**

- rate: <code>emqx_limiter_schema:rate()</code>
  * default: 
  `"infinity"`

  Rate for this bucket.

- capacity: <code>emqx_limiter_schema:capacity()</code>
  * default: 
  `"infinity"`

  The capacity of this token bucket.

- initial: <code>emqx_limiter_schema:initial()</code>
  * default: 
  `"0"`

  The initial number of tokens for this bucket.


## limiter:client_fields <a id='limiter-client_fields'></a>
Fields of the client level.


**Config paths**

 - <code>limiter.client</code>

**Env overrides**

 - <code>EMQX_LIMITER__CLIENT</code>


**Fields**

- bytes_in: <code>[limiter:client_opts](#limiter-client_opts)</code>
  * default: 
  `{}`

  The bytes_in limiter.
  This is used to limit the inbound bytes rate for this EMQX node.
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- message_in: <code>[limiter:client_opts](#limiter-client_opts)</code>
  * default: 
  `{}`

  The message in limiter.
  This is used to limit the inbound message numbers for this EMQX node
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- connection: <code>[limiter:client_opts](#limiter-client_opts)</code>
  * default: 
  `{}`

  The connection limiter.
  This is used to limit the connection rate for this EMQX node.
  Once the limit is reached, new connections will be refused

- message_routing: <code>[limiter:client_opts](#limiter-client_opts)</code>
  * default: 
  `{}`

  The message routing limiter.
  This is used to limit the forwarding rate for this EMQX node.
  Once the limit is reached, new publish will be refused

- internal: <code>[limiter:client_opts](#limiter-client_opts)</code>
  * default: 
  `{}`

  Limiter for EMQX internal app.


## limiter:client_opts <a id='limiter-client_opts'></a>
Settings for the client in bucket level.


**Config paths**

 - <code>limiter.client.bytes_in</code>
 - <code>limiter.client.connection</code>
 - <code>limiter.client.internal</code>
 - <code>limiter.client.message_in</code>
 - <code>limiter.client.message_routing</code>
 - <code>listeners.quic.$name.limiter.client.bytes_in</code>
 - <code>listeners.quic.$name.limiter.client.connection</code>
 - <code>listeners.quic.$name.limiter.client.message_in</code>
 - <code>listeners.quic.$name.limiter.client.message_routing</code>
 - <code>listeners.ssl.$name.limiter.client.bytes_in</code>
 - <code>listeners.ssl.$name.limiter.client.connection</code>
 - <code>listeners.ssl.$name.limiter.client.message_in</code>
 - <code>listeners.ssl.$name.limiter.client.message_routing</code>
 - <code>listeners.tcp.$name.limiter.client.bytes_in</code>
 - <code>listeners.tcp.$name.limiter.client.connection</code>
 - <code>listeners.tcp.$name.limiter.client.message_in</code>
 - <code>listeners.tcp.$name.limiter.client.message_routing</code>
 - <code>listeners.ws.$name.limiter.client.bytes_in</code>
 - <code>listeners.ws.$name.limiter.client.connection</code>
 - <code>listeners.ws.$name.limiter.client.message_in</code>
 - <code>listeners.ws.$name.limiter.client.message_routing</code>
 - <code>listeners.wss.$name.limiter.client.bytes_in</code>
 - <code>listeners.wss.$name.limiter.client.connection</code>
 - <code>listeners.wss.$name.limiter.client.message_in</code>
 - <code>listeners.wss.$name.limiter.client.message_routing</code>
 - <code>retainer.flow_control.batch_deliver_limiter.client</code>

**Env overrides**

 - <code>EMQX_LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LIMITER__CLIENT__INTERNAL</code>
 - <code>EMQX_LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CLIENT__BYTES_IN</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CLIENT__CONNECTION</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CLIENT__MESSAGE_IN</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CLIENT__MESSAGE_ROUTING</code>
 - <code>EMQX_RETAINER__FLOW_CONTROL__BATCH_DELIVER_LIMITER__CLIENT</code>


**Fields**

- rate: <code>emqx_limiter_schema:rate()</code>
  * default: 
  `"infinity"`

  Rate for this bucket.

- initial: <code>emqx_limiter_schema:initial()</code>
  * default: 
  `"0"`

  The initial number of tokens for this bucket.

- low_watermark: <code>emqx_limiter_schema:initial()</code>
  * default: 
  `"0"`

  If the remaining tokens are lower than this value,
  the check/consume will succeed, but it will be forced to wait for a short period of time.

- capacity: <code>emqx_limiter_schema:capacity()</code>
  * default: 
  `"infinity"`

  The capacity of per user.

- divisible: <code>boolean()</code>
  * default: 
  `false`

  Is it possible to split the number of requested tokens?

- max_retry_time: <code>emqx_schema:duration()</code>
  * default: 
  `"10s"`

  The maximum retry time when acquire failed.

- failure_strategy: <code>emqx_limiter_schema:failure_strategy()</code>
  * default: 
  `force`

  The strategy when all the retries failed.


## limiter:internal <a id='limiter-internal'></a>
Internal limiter.


**Config paths**

 - <code>retainer.flow_control.batch_deliver_limiter</code>

**Env overrides**

 - <code>EMQX_RETAINER__FLOW_CONTROL__BATCH_DELIVER_LIMITER</code>


**Fields**

- rate: <code>emqx_limiter_schema:rate()</code>
  * default: 
  `"infinity"`

  Rate for this bucket.

- capacity: <code>emqx_limiter_schema:capacity()</code>
  * default: 
  `"infinity"`

  The capacity of this token bucket.

- initial: <code>emqx_limiter_schema:initial()</code>
  * default: 
  `"0"`

  The initial number of tokens for this bucket.

- client: <code>[limiter:client_opts](#limiter-client_opts)</code>
  The rate limit for each user of the bucket


## limiter <a id='limiter'></a>
Settings for the rate limiter.


**Config paths**

 - <code>limiter</code>

**Env overrides**

 - <code>EMQX_LIMITER</code>


**Fields**

- bytes_in: <code>[limiter:node_opts](#limiter-node_opts)</code>
  * default: 
  `{}`

  The bytes_in limiter.
  This is used to limit the inbound bytes rate for this EMQX node.
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- message_in: <code>[limiter:node_opts](#limiter-node_opts)</code>
  * default: 
  `{}`

  The message in limiter.
  This is used to limit the inbound message numbers for this EMQX node
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- connection: <code>[limiter:node_opts](#limiter-node_opts)</code>
  * default: 
  `{}`

  The connection limiter.
  This is used to limit the connection rate for this EMQX node.
  Once the limit is reached, new connections will be refused

- message_routing: <code>[limiter:node_opts](#limiter-node_opts)</code>
  * default: 
  `{}`

  The message routing limiter.
  This is used to limit the forwarding rate for this EMQX node.
  Once the limit is reached, new publish will be refused

- internal: <code>[limiter:node_opts](#limiter-node_opts)</code>
  * default: 
  `{}`

  Limiter for EMQX internal app.

- client: <code>[limiter:client_fields](#limiter-client_fields)</code>
  * default: 
  ```
  {
    bytes_in {}
    connection {}
    internal {}
    message_in {}
    message_routing {}
  }
  ```

  The rate limit for each user of the bucket


## limiter:listener_client_fields <a id='limiter-listener_client_fields'></a>
Fields of the client level of the listener.


**Config paths**

 - <code>listeners.quic.$name.limiter.client</code>
 - <code>listeners.ssl.$name.limiter.client</code>
 - <code>listeners.tcp.$name.limiter.client</code>
 - <code>listeners.ws.$name.limiter.client</code>
 - <code>listeners.wss.$name.limiter.client</code>

**Env overrides**

 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER__CLIENT</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER__CLIENT</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER__CLIENT</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER__CLIENT</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER__CLIENT</code>


**Fields**

- bytes_in: <code>[limiter:client_opts](#limiter-client_opts)</code>
  The bytes_in limiter.
  This is used to limit the inbound bytes rate for this EMQX node.
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- message_in: <code>[limiter:client_opts](#limiter-client_opts)</code>
  The message in limiter.
  This is used to limit the inbound message numbers for this EMQX node
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- connection: <code>[limiter:client_opts](#limiter-client_opts)</code>
  The connection limiter.
  This is used to limit the connection rate for this EMQX node.
  Once the limit is reached, new connections will be refused

- message_routing: <code>[limiter:client_opts](#limiter-client_opts)</code>
  The message routing limiter.
  This is used to limit the forwarding rate for this EMQX node.
  Once the limit is reached, new publish will be refused


## limiter:listener_fields <a id='limiter-listener_fields'></a>
Fields of the listener.


**Config paths**

 - <code>listeners.quic.$name.limiter</code>
 - <code>listeners.ssl.$name.limiter</code>
 - <code>listeners.tcp.$name.limiter</code>
 - <code>listeners.ws.$name.limiter</code>
 - <code>listeners.wss.$name.limiter</code>

**Env overrides**

 - <code>EMQX_LISTENERS__QUIC__$NAME__LIMITER</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__LIMITER</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__LIMITER</code>
 - <code>EMQX_LISTENERS__WS__$NAME__LIMITER</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__LIMITER</code>


**Fields**

- bytes_in: <code>[limiter:bucket_opts](#limiter-bucket_opts)</code>
  The bytes_in limiter.
  This is used to limit the inbound bytes rate for this EMQX node.
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- message_in: <code>[limiter:bucket_opts](#limiter-bucket_opts)</code>
  The message in limiter.
  This is used to limit the inbound message numbers for this EMQX node
  Once the limit is reached, the restricted client will be slow down even be hung for a while.

- connection: <code>[limiter:bucket_opts](#limiter-bucket_opts)</code>
  The connection limiter.
  This is used to limit the connection rate for this EMQX node.
  Once the limit is reached, new connections will be refused

- message_routing: <code>[limiter:bucket_opts](#limiter-bucket_opts)</code>
  The message routing limiter.
  This is used to limit the forwarding rate for this EMQX node.
  Once the limit is reached, new publish will be refused

- client: <code>[limiter:listener_client_fields](#limiter-listener_client_fields)</code>
  The rate limit for each user of the bucket


## limiter:node_opts <a id='limiter-node_opts'></a>
Settings for the limiter of the node level.


**Config paths**

 - <code>limiter.bytes_in</code>
 - <code>limiter.connection</code>
 - <code>limiter.internal</code>
 - <code>limiter.message_in</code>
 - <code>limiter.message_routing</code>

**Env overrides**

 - <code>EMQX_LIMITER__BYTES_IN</code>
 - <code>EMQX_LIMITER__CONNECTION</code>
 - <code>EMQX_LIMITER__INTERNAL</code>
 - <code>EMQX_LIMITER__MESSAGE_IN</code>
 - <code>EMQX_LIMITER__MESSAGE_ROUTING</code>


**Fields**

- rate: <code>emqx_limiter_schema:rate()</code>
  * default: 
  `"infinity"`

  Rate for this bucket.

- burst: <code>emqx_limiter_schema:burst_rate()</code>
  * default: 
  `0`

  The burst, This value is based on rate.<br/>
   This value + rate = the maximum limit that can be achieved when limiter burst.


## modules:delayed <a id='modules-delayed'></a>
Settings for the delayed module.


**Config paths**

 - <code>delayed</code>

**Env overrides**

 - <code>EMQX_DELAYED</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable this feature

- max_delayed_messages: <code>integer()</code>
  * default: 
  `0`

  Maximum number of delayed messages (0 is no limit).


## modules:rewrite <a id='modules-rewrite'></a>
The topic rewriting function of EMQX supports rewriting topic A to topic B when the client subscribes to topics, publishes messages, and cancels subscriptions according to user-configured rules.
Each rewrite rule consists of three parts: subject filter, regular expression, and target expression.
Under the premise that the subject rewriting function is enabled, when EMQX receives a subject-based MQTT message such as a `PUBLISH` message,
it will use the subject of the message to sequentially match the subject filter part of the rule in the configuration file. If the match is successful,
the regular expression is used to extract the information in the subject, and then replaced with the target expression to form a new subject.
Variables in the format of `$N` can be used in the target expression to match the elements extracted from the regular expression.
The value of `$N` is the Nth element extracted from the regular expression. For example, `$1` is the regular expression. The first element extracted by the expression.
It should be noted that EMQX uses reverse order to read the rewrite rules in the configuration file.
When a topic can match the topic filter of multiple topic rewrite rules at the same time, EMQX will only use the first rule it matches. Rewrite.
If the regular expression in this rule does not match the subject of the MQTT message, the rewriting will fail, and no other rules will be attempted for rewriting.
Therefore, users need to carefully design MQTT message topics and topic rewriting rules when using them.


**Config paths**

 - <code>rewrite.$INDEX</code>

**Env overrides**

 - <code>EMQX_REWRITE__$INDEX</code>


**Fields**

- action: <code>subscribe | publish | all</code>
  Topic rewriting takes effect on the type of operation:
    - `subscribe`: Rewrite topic when client do subscribe.
    - `publish`: Rewrite topic when client do publish.
    - `all`: Both

- source_topic: <code>binary()</code>
  Source topic, specified by the client.

- dest_topic: <code>binary()</code>
  Destination topic.

- re: <code>binary()</code>
  Regular expressions


## modules:telemetry <a id='modules-telemetry'></a>
Settings for the telemetry module.


**Config paths**

 - <code>telemetry</code>

**Env overrides**

 - <code>EMQX_TELEMETRY</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable telemetry.


## modules:topic_metrics <a id='modules-topic_metrics'></a>



**Config paths**

 - <code>topic_metrics.$INDEX</code>

**Env overrides**

 - <code>EMQX_TOPIC_METRICS__$INDEX</code>


**Fields**

- topic: <code>binary()</code>
  Collect metrics for the topic.


## topology <a id='topology'></a>
Topology of MongoDB.


**Config paths**

 - <code>authentication.$INDEX.topology</code>
 - <code>authorization.sources.$INDEX.topology</code>
 - <code>gateway.coap.authentication.topology</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.topology</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.topology</code>
 - <code>gateway.exproto.authentication.topology</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.topology</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.topology</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.topology</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.topology</code>
 - <code>gateway.lwm2m.authentication.topology</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.topology</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.topology</code>
 - <code>gateway.mqttsn.authentication.topology</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.topology</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.topology</code>
 - <code>gateway.stomp.authentication.topology</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.topology</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.topology</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.topology</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.topology</code>
 - <code>listeners.ws.$name.authentication.$INDEX.topology</code>
 - <code>listeners.wss.$name.authentication.$INDEX.topology</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__TOPOLOGY</code>
 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__TOPOLOGY</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__TOPOLOGY</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__TOPOLOGY</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__TOPOLOGY</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__TOPOLOGY</code>


**Fields**

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- max_overflow: <code>non_neg_integer()</code>
  * default: 
  `0`

  Max Overflow.

- overflow_ttl: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- overflow_check_period: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- local_threshold_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- connect_timeout_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- socket_timeout_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- server_selection_timeout_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- wait_queue_timeout_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- heartbeat_frequency_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.

- min_heartbeat_frequency_ms: <code>emqx_schema:duration_ms()</code>
  Time interval, such as timeout or TTL.


## zone:conn_congestion <a id='zone-conn_congestion'></a>
Settings for `conn_congestion` alarm.

Sometimes the MQTT connection (usually an MQTT subscriber) may
get "congested", because there are too many packets to be sent.
The socket tries to buffer the packets until the buffer is
full. If more packets arrive after that, the packets will be
"pending" in the queue, and we consider the connection
congested.

Note: `sndbuf` can be set to larger value if the
alarm is triggered too often.
The name of the alarm is of format `conn_congestion/<ClientID>/<Username>`,
where the `<ClientID>` is the client ID of the congested MQTT connection,
and `<Username>` is the username or `unknown_user`.


**Config paths**

 - <code>zones.$name.conn_congestion</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__CONN_CONGESTION</code>


**Fields**

- enable_alarm: <code>boolean()</code>
  Enable or disable connection congestion alarm.

- min_alarm_sustain_duration: <code>emqx_schema:duration()</code>
  Minimal time before clearing the alarm.<br/>The alarm is cleared only when there's no pending data in<br/>the queue, and at least <code>min_alarm_sustain_duration</code>milliseconds passed since the last time we considered the connection 'congested'.<br/>This is to avoid clearing and raising the alarm again too often.


## zone:flapping_detect <a id='zone-flapping_detect'></a>
This config controls the allowed maximum number of `CONNECT` packets received
from the same clientid in a time frame defined by `window_time`.
After the limit is reached, successive `CONNECT` requests are forbidden
(banned) until the end of the time period defined by `ban_time`.


**Config paths**

 - <code>zones.$name.flapping_detect</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__FLAPPING_DETECT</code>


**Fields**

- enable: <code>boolean()</code>
  Enable flapping connection detection feature.

- max_count: <code>integer()</code>
  The maximum number of disconnects allowed for a MQTT Client in `window_time`

- window_time: <code>emqx_schema:duration()</code>
  The time window for flapping detection.

- ban_time: <code>emqx_schema:duration()</code>
  How long the flapping clientid will be banned.


## zone:force_gc <a id='zone-force_gc'></a>
Force garbage collection in MQTT connection process after
 they process certain number of messages or bytes of data.


**Config paths**

 - <code>zones.$name.force_gc</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__FORCE_GC</code>


**Fields**

- enable: <code>boolean()</code>
  Enable forced garbage collection.

- count: <code>0..inf</code>
  GC the process after this many received messages.

- bytes: <code>emqx_schema:bytesize()</code>
  GC the process after specified number of bytes have passed through.


## zone:force_shutdown <a id='zone-force_shutdown'></a>
When the process message queue length, or the memory bytes
reaches a certain value, the process is forced to close.

Note: "message queue" here refers to the "message mailbox"
of the Erlang process, not the `mqueue` of QoS 1 and QoS 2.


**Config paths**

 - <code>zones.$name.force_shutdown</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__FORCE_SHUTDOWN</code>


**Fields**

- enable: <code>boolean()</code>
  Enable `force_shutdown` feature.

- max_message_queue_len: <code>0..inf</code>
  Maximum message queue length.

- max_heap_size: <code>emqx_schema:wordsize()</code>
  Total heap size


## zone:mqtt <a id='zone-mqtt'></a>
Global MQTT configuration.<br/>The configs here work as default values which can be overridden
in <code>zone</code> configs


**Config paths**

 - <code>zones.$name.mqtt</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__MQTT</code>


**Fields**

- idle_timeout: <code>infinity | emqx_schema:duration()</code>
  After the TCP connection is established, if the MQTT CONNECT packet from the client is not received within the time specified by <code>idle_timeout</code>, the connection will be disconnected.

- max_packet_size: <code>emqx_schema:bytesize()</code>
  Maximum MQTT packet size allowed.

- max_clientid_len: <code>23..65535</code>
  Maximum allowed length of MQTT Client ID.

- max_topic_levels: <code>1..65535</code>
  Maximum topic levels allowed.

- max_qos_allowed: <code>qos()</code>
  Maximum QoS allowed.

- max_topic_alias: <code>0..65535</code>
  Maximum topic alias, 0 means no topic alias supported.

- retain_available: <code>boolean()</code>
  Whether to enable support for MQTT retained message.

- wildcard_subscription: <code>boolean()</code>
  Whether to enable support for MQTT wildcard subscription.

- shared_subscription: <code>boolean()</code>
  Whether to enable support for MQTT shared subscription.

- exclusive_subscription: <code>boolean()</code>
  Whether to enable support for MQTT exclusive subscription.

- ignore_loop_deliver: <code>boolean()</code>
  Ignore loop delivery of messages for MQTT v3.1.1/v3.1.0, similar to <code>No Local</code> subscription option in MQTT 5.0.

- strict_mode: <code>boolean()</code>
  Parse MQTT messages in strict mode.
  When set to true, invalid utf8 strings in for example client ID, topic name, etc. will cause the client to be disconnected

- response_information: <code>string()</code>
  Specify the response information returned to the client. This feature is disabled if is set to "". Applies only to clients using MQTT 5.0.

- server_keepalive: <code>integer() | disabled</code>
  The keep alive that EMQX requires the client to use. If configured as <code>disabled</code>, it means that the keep alive specified by the client will be used. Requires <code>Server Keep Alive</code> in MQTT 5.0, so it is only applicable to clients using MQTT 5.0 protocol.

- keepalive_backoff: <code>number()</code>
  The backoff multiplier used by the broker to determine the client keep alive timeout. If EMQX doesn't receive any packet in <code>Keep Alive * Backoff * 2</code> seconds, EMQX will close the current connection.

- max_subscriptions: <code>1..inf | infinity</code>
  Maximum number of subscriptions allowed per client.

- upgrade_qos: <code>boolean()</code>
  Force upgrade of QoS level according to subscription.

- max_inflight: <code>1..65535</code>
  Maximum number of QoS 1 and QoS 2 messages that are allowed to be delivered simultaneously before completing the acknowledgment.

- retry_interval: <code>emqx_schema:duration()</code>
  Retry interval for QoS 1/2 message delivering.

- max_awaiting_rel: <code>integer() | infinity</code>
  For each publisher session, the maximum number of outstanding QoS 2 messages pending on the client to send PUBREL. After reaching this limit, new QoS 2 PUBLISH requests will be rejected with `147(0x93)` until either PUBREL is received or timed out.

- await_rel_timeout: <code>emqx_schema:duration()</code>
  For client to broker QoS 2 message, the time limit for the broker to wait before the `PUBREL` message is received. The wait is aborted after timed out, meaning the packet ID is freed for new `PUBLISH` requests. Receiving a stale `PUBREL` causes a warning level log. Note, the message is delivered to subscribers before entering the wait for PUBREL.

- session_expiry_interval: <code>emqx_schema:duration()</code>
  Specifies how long the session will expire after the connection is disconnected, only for non-MQTT 5.0 connections.

- max_mqueue_len: <code>non_neg_integer() | infinity</code>
  Maximum queue length. Enqueued messages when persistent client disconnected, or inflight window is full.

- mqueue_priorities: <code>map() | disabled</code>
  Topic priorities. Priority number [1-255]
  There's no priority table by default, hence all messages are treated equal.
  **NOTE**: Comma and equal signs are not allowed for priority topic names.
  **NOTE**: Messages for topics not in the priority table are treated as either highest or lowest priority depending on the configured value for <code>mqtt.mqueue_default_priority</code>.
  **Examples**:
  To configure <code>"topic/1" > "topic/2"</code>:
  <code>mqueue_priorities: {"topic/1": 10, "topic/2": 8}</code>

- mqueue_default_priority: <code>highest | lowest</code>
  Default topic priority, which will be used by topics not in <code>Topic Priorities</code> (<code>mqueue_priorities</code>).

- mqueue_store_qos0: <code>boolean()</code>
  Specifies whether to store QoS 0 messages in the message queue while the connection is down but the session remains.

- use_username_as_clientid: <code>boolean()</code>
  Whether to user Client ID as Username.
  This setting takes effect later than <code>Use Peer Certificate as Username</code> (<code>peer_cert_as_username</code>) and <code>Use peer certificate as Client ID</code> (<code>peer_cert_as_clientid</code>).

- peer_cert_as_username: <code>disabled | cn | dn | crt | pem | md5</code>
  Use the CN, DN field in the peer certificate or the entire certificate content as Username. Only works for the TLS connection.
  Supported configurations are the following:
  - <code>cn</code>: Take the CN field of the certificate as Username
  - <code>dn</code>: Take the DN field of the certificate as Username
  - <code>crt</code>: Take the content of the <code>DER</code> or <code>PEM</code> certificate as Username
  - <code>pem</code>: Convert <code>DER</code> certificate content to <code>PEM</code> format as Username
  - <code>md5</code>: Take the MD5 value of the content of the <code>DER</code> or <code>PEM</code> certificate as Username

- peer_cert_as_clientid: <code>disabled | cn | dn | crt | pem | md5</code>
  Use the CN, DN field in the peer certificate or the entire certificate content as Client ID. Only works for the TLS connection.
  Supported configurations are the following:
  - <code>cn</code>: Take the CN field of the certificate as Client ID
  - <code>dn</code>: Take the DN field of the certificate as Client ID
  - <code>crt</code>: Take the content of the <code>DER</code> or <code>PEM</code> certificate as Client ID
  - <code>pem</code>: Convert <code>DER</code> certificate content to <code>PEM</code> format as Client ID
  - <code>md5</code>: Take the MD5 value of the content of the <code>DER</code> or <code>PEM</code> certificate as Client ID


## zone:overload_protection <a id='zone-overload_protection'></a>
Overload protection mechanism monitors the load of the system and temporarily
disables some features (such as accepting new connections) when the load is high.


**Config paths**

 - <code>zones.$name.overload_protection</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__OVERLOAD_PROTECTION</code>


**Fields**

- enable: <code>boolean()</code>
  React on system overload or not.

- backoff_delay: <code>0..inf</code>
  When at high load, some unimportant tasks could be delayed for execution, here set the duration in milliseconds precision.

- backoff_gc: <code>boolean()</code>
  When at high load, skip forceful GC.

- backoff_hibernation: <code>boolean()</code>
  When at high load, skip process hibernation.

- backoff_new_conn: <code>boolean()</code>
  When at high load, close new incoming connections.


## zone:stats <a id='zone-stats'></a>
Enable/disable statistic data collection.
Statistic data such as message receive/send count/rate etc. It provides insights of system performance and helps to diagnose issues. You can find statistic data from the dashboard, or from the '/stats' API.


**Config paths**

 - <code>zones.$name.stats</code>

**Env overrides**

 - <code>EMQX_ZONES__$NAME__STATS</code>


**Fields**

- enable: <code>boolean()</code>
  Enable/disable statistic data collection.


## authn-hash:bcrypt <a id='authn-hash-bcrypt'></a>
Settings for bcrypt password hashing algorithm.


**Config paths**

 - <code>authentication.$INDEX.password_hash_algorithm</code>
 - <code>gateway.coap.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.ws.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.wss.$name.authentication.$INDEX.password_hash_algorithm</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>


**Fields**

- name: <code>bcrypt</code>
  BCRYPT password hashing.


## authn-hash:bcrypt_rw <a id='authn-hash-bcrypt_rw'></a>
Settings for bcrypt password hashing algorithm (for DB backends with write capability).


**Config paths**

 - <code>authentication.$INDEX.password_hash_algorithm</code>
 - <code>gateway.coap.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.ws.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.wss.$name.authentication.$INDEX.password_hash_algorithm</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>


**Fields**

- name: <code>bcrypt</code>
  BCRYPT password hashing.

- salt_rounds: <code>integer()</code>
  * default: 
  `10`

  Salt rounds for BCRYPT password generation.


## authn-hash:other_algorithms <a id='authn-hash-other_algorithms'></a>
Settings for other password hashing algorithms.


**Config paths**

 - <code>authentication.$INDEX.password_hash_algorithm</code>
 - <code>gateway.coap.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.ws.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.wss.$name.authentication.$INDEX.password_hash_algorithm</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>


**Fields**

- name: <code>plain | md5 | sha | sha256 | sha512</code>
  Simple password hashing algorithm.

- salt_position: <code>disable | prefix | suffix</code>
  * default: 
  `prefix`

  Salt position for PLAIN, MD5, SHA, SHA256 and SHA512 algorithms.


## authn-hash:pbkdf2 <a id='authn-hash-pbkdf2'></a>
Settings for PBKDF2 password hashing algorithm.


**Config paths**

 - <code>authentication.$INDEX.password_hash_algorithm</code>
 - <code>gateway.coap.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.password_hash_algorithm</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.password_hash_algorithm</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.ws.$name.authentication.$INDEX.password_hash_algorithm</code>
 - <code>listeners.wss.$name.authentication.$INDEX.password_hash_algorithm</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__PASSWORD_HASH_ALGORITHM</code>


**Fields**

- name: <code>pbkdf2</code>
  PBKDF2 password hashing.

- mac_fun: <code>md4 | md5 | ripemd160 | sha | sha224 | sha256 | sha384 | sha512</code>
  Specifies mac_fun for PBKDF2 hashing algorithm.

- iterations: <code>integer()</code>
  Iteration count for PBKDF2 hashing algorithm.

- dk_length: <code>integer()</code>
  Derived length for PBKDF2 hashing algorithm. If not specified, calculated automatically based on `mac_fun`.


## authn-psk:psk_authentication <a id='authn-psk-psk_authentication'></a>
PSK stands for 'Pre-Shared Keys'.
This config to enable TLS-PSK authentication.

Important! Make sure the SSL listener with only <code>tlsv1.2</code> enabled, and also PSK cipher suites
configured, such as <code>RSA-PSK-AES256-GCM-SHA384</code>.

See listener SSL options config for more details.

The IDs and secrets can be provided from a file which is configurable by the <code>init_file</code> field.



**Config paths**

 - <code>psk_authentication</code>

**Env overrides**

 - <code>EMQX_PSK_AUTHENTICATION</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Whether to enable TLS PSK support

- init_file: <code>binary()</code>
  If init_file is specified, EMQX will import PSKs from the file into the built-in database at startup for use by the runtime.
  The file has to be structured line-by-line, each line must be in the format of <code>PSKIdentity:SharedSecret</code>.
  For example: <code>mydevice1:c2VjcmV0</code>

- separator: <code>binary()</code>
  * default: 
  `":"`

  The separator between <code>PSKIdentity</code> and <code>SharedSecret</code> in the PSK file

- chunk_size: <code>integer()</code>
  * default: 
  `50`

  The size of each chunk used to import to the built-in database from PSK file


## auto_subscribe <a id='auto_subscribe'></a>
After the device logs in successfully, the subscription is automatically completed for the device through the pre-defined subscription representation. Supports the use of placeholders.


**Config paths**

 - <code>auto_subscribe</code>

**Env overrides**

 - <code>EMQX_AUTO_SUBSCRIBE</code>


**Fields**

- topics: <code>[[auto_subscribe:topic](#auto_subscribe-topic)]</code>
  * default: 
  `[]`

  After the device logs in successfully, the subscription is automatically completed for the device through the pre-defined subscription representation. Supports the use of placeholders.


## auto_subscribe:topic <a id='auto_subscribe-topic'></a>
Topic name, placeholders are supported. For example: client/${clientid}/username/${username}/host/${host}/port/${port}
Required field, and cannot be empty string


**Config paths**

 - <code>auto_subscribe.topics.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTO_SUBSCRIBE__TOPICS__$INDEX</code>


**Fields**

- topic: <code>binary()</code>
  Topic name, placeholders are supported. For example: client/${clientid}/username/${username}/host/${host}/port/${port}
  Required field, and cannot be empty string

- qos: <code>qos()</code>
  * default: 
  `0`

  Default value 0. Quality of service.
  At most once (0)
  At least once (1)
  Exactly once (2)

- rh: <code>0..2</code>
  * default: 
  `0`

  Default value 0. This option is used to specify whether the server forwards the retained message to the client when establishing a subscription.
  Retain Handling is equal to 0, as long as the client successfully subscribes, the server will send the retained message.
  Retain Handling is equal to 1, if the client successfully subscribes and this subscription does not exist previously, the server sends the retained message. After all, sometimes the client re-initiate the subscription just to change the QoS, but it does not mean that it wants to receive the reserved messages again.
  Retain Handling is equal to 2, even if the client successfully subscribes, the server does not send the retained message.

- rap: <code>0..1</code>
  * default: 
  `0`

  Default value 0. This option is used to specify whether the server retains the RETAIN mark when forwarding messages to the client, and this option does not affect the RETAIN mark in the retained message. Therefore, when the option Retain As Publish is set to 0, the client will directly distinguish whether this is a normal forwarded message or a retained message according to the RETAIN mark in the message, instead of judging whether this message is the first received after subscribing(the forwarded message may be sent before the retained message, which depends on the specific implementation of different brokers).

- nl: <code>0..1</code>
  * default: 
  `0`

  Default value 0.
  MQTT v3.1.1： if you subscribe to the topic published by yourself, you will receive all messages that you published.
  MQTT v5: if you set this option as 1 when subscribing, the server will not forward the message you published to you.


## bridge_mqtt:config <a id='bridge_mqtt-config'></a>
The config for MQTT Bridges.


**Config paths**

 - <code>bridges.mqtt.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- resource_opts: <code>[bridge_mqtt:creation_opts](#bridge_mqtt-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- mode: <code>cluster_shareload</code>
  * default: 
  `cluster_shareload`

  The mode of the MQTT Bridge.<br/>
  - cluster_shareload: create an MQTT connection on each node in the emqx cluster.<br/>
  In 'cluster_shareload' mode, the incoming load from the remote broker is shared by
  using shared subscription.<br/>
  Note that the 'clientid' is suffixed by the node name, this is to avoid
  clientid conflicts between different nodes. And we can only use shared subscription
  topic filters for <code>remote.topic</code> of ingress connections.

- server: <code>emqx_schema:host_port()</code>
  The host and port of the remote MQTT broker

- reconnect_interval: <code>string()</code>
  * default: 
  `"15s"`

  Reconnect interval. Delay for the MQTT bridge to retry establishing the connection in case of transportation failure. Time interval is a string that contains a number followed by time unit:<br/>- `ms` for milliseconds,
  - `s` for seconds,
  - `m` for minutes,
  - `h` for hours;
  <br/>or combination of whereof: `1h5m0s`

- proto_ver: <code>v3 | v4 | v5</code>
  * default: 
  `v4`

  The MQTT protocol version

- bridge_mode: <code>boolean()</code>
  * default: 
  `false`

  If enable bridge mode.
  NOTE: This setting is only for MQTT protocol version older than 5.0, and the remote MQTT
  broker MUST support this feature.
      

- username: <code>binary()</code>
  The username of the MQTT protocol

- password: <code>binary()</code>
  The password of the MQTT protocol

- clean_start: <code>boolean()</code>
  * default: 
  `true`

  The clean-start or the clean-session of the MQTT protocol

- keepalive: <code>string()</code>
  * default: 
  `"300s"`

  MQTT Keepalive. Time interval is a string that contains a number followed by time unit:<br/>- `ms` for milliseconds,
  - `s` for seconds,
  - `m` for minutes,
  - `h` for hours;
  <br/>or combination of whereof: `1h5m0s`

- retry_interval: <code>string()</code>
  * default: 
  `"15s"`

  Message retry interval. Delay for the MQTT bridge to retry sending the QoS1/QoS2 messages in case of ACK not received. Time interval is a string that contains a number followed by time unit:<br/>- `ms` for milliseconds,
  - `s` for seconds,
  - `m` for minutes,
  - `h` for hours;
  <br/>or combination of whereof: `1h5m0s`

- max_inflight: <code>non_neg_integer()</code>
  * default: 
  `32`

  Max inflight (sent, but un-acked) messages of the MQTT protocol

- ssl: <code>[broker:ssl_client_opts](#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- ingress: <code>[connector-mqtt:ingress](#connector-mqtt-ingress)</code>
  The ingress config defines how this bridge receive messages from the remote MQTT broker, and then
          send them to the local broker.<br/>
          Template with variables is allowed in 'remote.qos', 'local.topic', 'local.qos', 'local.retain', 'local.payload'.<br/>
          NOTE: if this bridge is used as the input of a rule, and also 'local.topic' is
          configured, then messages got from the remote broker will be sent to both the 'local.topic' and
          the rule.

- egress: <code>[connector-mqtt:egress](#connector-mqtt-egress)</code>
  The egress config defines how this bridge forwards messages from the local broker to the remote broker.<br/>
  Template with variables is allowed in 'remote.topic', 'local.qos', 'local.retain', 'local.payload'.<br/>
  NOTE: if this bridge is used as the action of a rule, and also 'local.topic'
  is configured, then both the data got from the rule and the MQTT messages that matches
  'local.topic' will be forwarded.


## bridge_mqtt:creation_opts <a id='bridge_mqtt-creation_opts'></a>
Creation options.


**Config paths**

 - <code>bridges.mqtt.$name.resource_opts</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__RESOURCE_OPTS</code>


**Fields**

- worker_pool_size: <code>pos_integer()</code>
  * default: 
  `16`

  Resource worker pool size.

- health_check_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  Health check interval, in milliseconds.

- auto_restart_interval: <code>infinity | emqx_schema:duration_ms()</code>
  * default: 
  `"60s"`

  The auto restart interval after the resource is disconnected, in milliseconds.

- query_mode: <code>sync | async</code>
  * default: 
  `async`

  Query mode. Optional 'sync/async', default 'sync'.

- async_inflight_window: <code>pos_integer()</code>
  * default: 
  `100`

  Async query inflight window.

- enable_queue: <code>boolean()</code>
  * default: 
  `false`

  Queue mode enabled.

- max_queue_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  Maximum queue storage.


## bridge_webhook:config <a id='bridge_webhook-config'></a>
Configuration for an HTTP bridge.


**Config paths**

 - <code>bridges.webhook.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__WEBHOOK__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- resource_opts: <code>[bridge_webhook:creation_opts](#bridge_webhook-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- connect_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  The timeout when connecting to the HTTP server.

- retry_interval: <code>emqx_schema:duration()</code>
  Deprecated since 5.0.4.

- pool_type: <code>emqx_connector_http:pool_type()</code>
  * default: 
  `random`

  The type of the pool. Can be one of `random`, `hash`.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  The pool size.

- enable_pipelining: <code>pos_integer()</code>
  * default: 
  `100`

  A positive integer. Whether to send HTTP requests continuously, when set to 1, it means that after each HTTP request is sent, you need to wait for the server to return and then continue to send the next request.

- request: <code>[connector-http:request](#connector-http-request)</code>
  If the request is provided, the caller can send HTTP requests via
  <code>emqx_resource:query(ResourceId, {send_message, BridgeId, Message})</code>

- ssl: <code>[broker:ssl_client_opts](#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- url: <code>binary()</code>
  The URL of the HTTP Bridge.<br/>
  Template with variables is allowed in the path, but variables cannot be used in the scheme, host,
  or port part.<br/>
  For example, <code> http://localhost:9901/${topic} </code> is allowed, but
  <code> http://${host}:9901/message </code> or <code> http://localhost:${port}/message </code>
  is not allowed.

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to the HTTP server. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.<br/>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- method: <code>post | put | get | delete</code>
  * default: 
  `post`

  The method of the HTTP request. All the available methods are: post, put, get, delete.<br/>
  Template with variables is allowed.<br/>

- headers: <code>map()</code>
  * default: 
  ```
  {
    accept = "application/json"
    "cache-control" = "no-cache"
    connection = "keep-alive"
    "content-type" = "application/json"
    "keep-alive" = "timeout=5"
  }
  ```

  The headers of the HTTP request.<br/>
  Template with variables is allowed.

- body: <code>binary()</code>
  * default: 
  `"${payload}"`

  The body of the HTTP request.<br/>
  Template with variables is allowed.

- max_retries: <code>non_neg_integer()</code>
  * default: 
  `2`

  HTTP request max retry times if failed.

- request_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  HTTP request timeout.


## bridge_webhook:creation_opts <a id='bridge_webhook-creation_opts'></a>
Creation options.


**Config paths**

 - <code>bridges.webhook.$name.resource_opts</code>

**Env overrides**

 - <code>EMQX_BRIDGES__WEBHOOK__$NAME__RESOURCE_OPTS</code>


**Fields**

- worker_pool_size: <code>pos_integer()</code>
  * default: 
  `16`

  Resource worker pool size.

- health_check_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  Health check interval, in milliseconds.

- auto_restart_interval: <code>infinity | emqx_schema:duration_ms()</code>
  * default: 
  `"60s"`

  The auto restart interval after the resource is disconnected, in milliseconds.

- query_mode: <code>sync | async</code>
  * default: 
  `async`

  Query mode. Optional 'sync/async', default 'sync'.

- async_inflight_window: <code>pos_integer()</code>
  * default: 
  `100`

  Async query inflight window.

- enable_queue: <code>boolean()</code>
  * default: 
  `false`

  Queue mode enabled.

- max_queue_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  Maximum queue storage.


## connector-http:request <a id='connector-http-request'></a>



**Config paths**

 - <code>authentication.$INDEX.request</code>
 - <code>authorization.sources.$INDEX.request</code>
 - <code>bridges.webhook.$name.request</code>
 - <code>gateway.coap.authentication.request</code>
 - <code>gateway.coap.listeners.dtls.$name.authentication.request</code>
 - <code>gateway.coap.listeners.udp.$name.authentication.request</code>
 - <code>gateway.exproto.authentication.request</code>
 - <code>gateway.exproto.listeners.dtls.$name.authentication.request</code>
 - <code>gateway.exproto.listeners.ssl.$name.authentication.request</code>
 - <code>gateway.exproto.listeners.tcp.$name.authentication.request</code>
 - <code>gateway.exproto.listeners.udp.$name.authentication.request</code>
 - <code>gateway.lwm2m.authentication.request</code>
 - <code>gateway.lwm2m.listeners.dtls.$name.authentication.request</code>
 - <code>gateway.lwm2m.listeners.udp.$name.authentication.request</code>
 - <code>gateway.mqttsn.authentication.request</code>
 - <code>gateway.mqttsn.listeners.dtls.$name.authentication.request</code>
 - <code>gateway.mqttsn.listeners.udp.$name.authentication.request</code>
 - <code>gateway.stomp.authentication.request</code>
 - <code>gateway.stomp.listeners.ssl.$name.authentication.request</code>
 - <code>gateway.stomp.listeners.tcp.$name.authentication.request</code>
 - <code>listeners.ssl.$name.authentication.$INDEX.request</code>
 - <code>listeners.tcp.$name.authentication.$INDEX.request</code>
 - <code>listeners.ws.$name.authentication.$INDEX.request</code>
 - <code>listeners.wss.$name.authentication.$INDEX.request</code>

**Env overrides**

 - <code>EMQX_AUTHENTICATION__$INDEX__REQUEST</code>
 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX__REQUEST</code>
 - <code>EMQX_BRIDGES__WEBHOOK__$NAME__REQUEST</code>
 - <code>EMQX_GATEWAY__COAP__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__DTLS__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__COAP__LISTENERS__UDP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__EXPROTO__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__DTLS__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__SSL__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__TCP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__EXPROTO__LISTENERS__UDP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__LWM2M__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__DTLS__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__LWM2M__LISTENERS__UDP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__MQTTSN__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__DTLS__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__MQTTSN__LISTENERS__UDP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__STOMP__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__SSL__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_GATEWAY__STOMP__LISTENERS__TCP__$NAME__AUTHENTICATION__REQUEST</code>
 - <code>EMQX_LISTENERS__SSL__$NAME__AUTHENTICATION__$INDEX__REQUEST</code>
 - <code>EMQX_LISTENERS__TCP__$NAME__AUTHENTICATION__$INDEX__REQUEST</code>
 - <code>EMQX_LISTENERS__WS__$NAME__AUTHENTICATION__$INDEX__REQUEST</code>
 - <code>EMQX_LISTENERS__WSS__$NAME__AUTHENTICATION__$INDEX__REQUEST</code>


**Fields**

- method: <code>binary()</code>
  HTTP method.

- path: <code>binary()</code>
  URL path.

- body: <code>binary()</code>
  HTTP request body.

- headers: <code>map()</code>
  List of HTTP headers.

- max_retries: <code>non_neg_integer()</code>
  Max retry times if error on sending request.

- request_timeout: <code>emqx_schema:duration_ms()</code>
  HTTP request timeout.


## connector-mqtt:egress <a id='connector-mqtt-egress'></a>
The egress config defines how this bridge forwards messages from the local broker to the remote broker.<br/>
Template with variables is allowed in 'remote.topic', 'local.qos', 'local.retain', 'local.payload'.<br/>
NOTE: if this bridge is used as the action of a rule, and also 'local.topic'
is configured, then both the data got from the rule and the MQTT messages that matches
'local.topic' will be forwarded.


**Config paths**

 - <code>bridges.mqtt.$name.egress</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__EGRESS</code>


**Fields**

- local: <code>[connector-mqtt:egress_local](#connector-mqtt-egress_local)</code>
  The configs about receiving messages from local broker.

- remote: <code>[connector-mqtt:egress_remote](#connector-mqtt-egress_remote)</code>
  The configs about sending message to the remote broker.


## connector-mqtt:egress_local <a id='connector-mqtt-egress_local'></a>
The configs about receiving messages from local broker.


**Config paths**

 - <code>bridges.mqtt.$name.egress.local</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__EGRESS__LOCAL</code>


**Fields**

- topic: <code>binary()</code>
  The local topic to be forwarded to the remote broker


## connector-mqtt:egress_remote <a id='connector-mqtt-egress_remote'></a>
The configs about sending message to the remote broker.


**Config paths**

 - <code>bridges.mqtt.$name.egress.remote</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__EGRESS__REMOTE</code>


**Fields**

- topic: <code>binary()</code>
  Forward to which topic of the remote broker.<br/>
  Template with variables is allowed.

- qos: <code>qos() | binary()</code>
  The QoS of the MQTT message to be sent.<br/>
  Template with variables is allowed.

- retain: <code>boolean() | binary()</code>
  The 'retain' flag of the MQTT message to be sent.<br/>
  Template with variables is allowed.

- payload: <code>binary()</code>
  The payload of the MQTT message to be sent.<br/>
  Template with variables is allowed.


## connector-mqtt:ingress <a id='connector-mqtt-ingress'></a>
The ingress config defines how this bridge receive messages from the remote MQTT broker, and then
        send them to the local broker.<br/>
        Template with variables is allowed in 'remote.qos', 'local.topic', 'local.qos', 'local.retain', 'local.payload'.<br/>
        NOTE: if this bridge is used as the input of a rule, and also 'local.topic' is
        configured, then messages got from the remote broker will be sent to both the 'local.topic' and
        the rule.


**Config paths**

 - <code>bridges.mqtt.$name.ingress</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__INGRESS</code>


**Fields**

- remote: <code>[connector-mqtt:ingress_remote](#connector-mqtt-ingress_remote)</code>
  The configs about subscribing to the remote broker.

- local: <code>[connector-mqtt:ingress_local](#connector-mqtt-ingress_local)</code>
  The configs about sending message to the local broker.


## connector-mqtt:ingress_local <a id='connector-mqtt-ingress_local'></a>
The configs about sending message to the local broker.


**Config paths**

 - <code>bridges.mqtt.$name.ingress.local</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__INGRESS__LOCAL</code>


**Fields**

- topic: <code>binary()</code>
  Send messages to which topic of the local broker.<br/>
  Template with variables is allowed.

- qos: <code>qos() | binary()</code>
  * default: 
  `"${qos}"`

  The QoS of the MQTT message to be sent.<br/>
  Template with variables is allowed.

- retain: <code>boolean() | binary()</code>
  * default: 
  `"${retain}"`

  The 'retain' flag of the MQTT message to be sent.<br/>
  Template with variables is allowed.

- payload: <code>binary()</code>
  The payload of the MQTT message to be sent.<br/>
  Template with variables is allowed.


## connector-mqtt:ingress_remote <a id='connector-mqtt-ingress_remote'></a>
The configs about subscribing to the remote broker.


**Config paths**

 - <code>bridges.mqtt.$name.ingress.remote</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MQTT__$NAME__INGRESS__REMOTE</code>


**Fields**

- topic: <code>binary()</code>
  Receive messages from which topic of the remote broker

- qos: <code>qos() | binary()</code>
  * default: 
  `1`

  The QoS level to be used when subscribing to the remote broker


## plugin:plugins <a id='plugin-plugins'></a>

Manage EMQX plugins.<br/>
Plugins can be pre-built as a part of EMQX package,
or installed as a standalone package in a location specified by
<code>install_dir</code> config key<br/>
The standalone-installed plugins are referred to as 'external' plugins.



**Config paths**

 - <code>plugins</code>

**Env overrides**

 - <code>EMQX_PLUGINS</code>


**Fields**

- states: <code>[[plugin:state](#plugin-state)]</code>
  * default: 
  `[]`

  An array of plugins in the desired states.<br/>
  The plugins are started in the defined order

- install_dir: <code>string()</code>
  * default: 
  `"plugins"`

  The installation directory for the external plugins.
  The plugin beam files and configuration files should reside in
  the subdirectory named as <code>emqx_foo_bar-0.1.0</code>.
  <br/>
  NOTE: For security reasons, this directory should **NOT** be writable
  by anyone except <code>emqx</code> (or any user which runs EMQX).

- check_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  Check interval: check if the status of the plugins in the cluster is consistent, <br/>
  if the results of 3 consecutive checks are not consistent, then alarm.


## plugin:state <a id='plugin-state'></a>
A per-plugin config to describe the desired state of the plugin.


**Config paths**

 - <code>plugins.states.$INDEX</code>

**Env overrides**

 - <code>EMQX_PLUGINS__STATES__$INDEX</code>


**Fields**

- name_vsn: <code>string()</code>
  The {name}-{version} of the plugin.<br/>
  It should match the plugin application name-version as the for the plugin release package name<br/>
  For example: my_plugin-0.1.0.

- enable: <code>boolean()</code>
  Set to 'true' to enable this plugin


## prometheus <a id='prometheus'></a>
Settings for reporting metrics to Prometheus


**Config paths**

 - <code>prometheus</code>

**Env overrides**

 - <code>EMQX_PROMETHEUS</code>


**Fields**

- push_gateway_server: <code>string()</code>
  * default: 
  `"http://127.0.0.1:9091"`

  URL of Prometheus server

- interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  Data reporting interval

- enable: <code>boolean()</code>
  * default: 
  `false`

  Turn Prometheus data pushing on or off


## retainer:flow_control <a id='retainer-flow_control'></a>
Retainer batching and rate limiting.


**Config paths**

 - <code>retainer.flow_control</code>

**Env overrides**

 - <code>EMQX_RETAINER__FLOW_CONTROL</code>


**Fields**

- batch_read_number: <code>non_neg_integer()</code>
  * default: 
  `0`

  Size of the batch when reading messages from storage. 0 means no limit.

- batch_deliver_number: <code>0..1000</code>
  * default: 
  `0`

  The number of retained messages can be delivered per batch.

- batch_deliver_limiter: <code>[limiter:internal](#limiter-internal)</code>
  The rate limiter name for retained messages' delivery.
  Limiter helps to avoid delivering too many messages to the client at once, which may cause the client to block or crash, or drop messages due to exceeding the size of the message queue.
  The names of the available rate limiters are taken from the existing rate limiters under `limiter.batch`.
  If this field is empty, limiter is not used.


## retainer:mnesia_config <a id='retainer-mnesia_config'></a>
Configuration of the internal database storing retained messages.


**Config paths**

 - <code>retainer.backend</code>

**Env overrides**

 - <code>EMQX_RETAINER__BACKEND</code>


**Fields**

- type: <code>built_in_database</code>
  * default: 
  `built_in_database`

  Backend type.

- storage_type: <code>ram | disc</code>
  * default: 
  `ram`

  Specifies whether the messages are stored in RAM or persisted on disc.

- max_retained_messages: <code>non_neg_integer()</code>
  * default: 
  `0`

  Maximum number of retained messages. 0 means no limit.

- index_specs: <code>[[integer()]]</code>
  * default: 
  ```
  [
    [1, 2, 3],
    [1, 3],
    [2, 3],
    [3]
  ]
  ```

  Retainer index specifications: list of arrays of positive ascending integers. Each array specifies an index. Numbers in an index specification are 1-based word positions in topics. Words from specified positions will be used for indexing.<br/>For example, it is good to have <code>[2, 4]</code> index to optimize <code>+/X/+/Y/...</code> topic wildcard subscriptions.


## retainer <a id='retainer'></a>
Configuration related to handling `PUBLISH` packets with a `retain` flag set to 1.


**Config paths**

 - <code>retainer</code>

**Env overrides**

 - <code>EMQX_RETAINER</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable retainer feature

- msg_expiry_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"0s"`

  Message retention time. 0 means message will never be expired.

- msg_clear_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"0s"`

  Periodic interval for cleaning up expired messages.
  Never clear if the value is 0.
        

- flow_control: <code>[retainer:flow_control](#retainer-flow_control)</code>
  * default: 
  `{}`

  Flow control.

- max_payload_size: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  Maximum retained message size.

- stop_publish_clear_msg: <code>boolean()</code>
  * default: 
  `false`

  When the retained flag of the `PUBLISH` message is set and Payload is empty,
  whether to continue to publish the message.
  See:
  http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718038

- backend: <code>[retainer:mnesia_config](#retainer-mnesia_config)</code>
  Settings for the database storing the retained messages.


## slow_subs <a id='slow_subs'></a>
Configuration for `slow_subs` feature.


**Config paths**

 - <code>slow_subs</code>

**Env overrides**

 - <code>EMQX_SLOW_SUBS</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable this feature

- threshold: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"500ms"`

  The latency threshold for statistics

- expire_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"300s"`

  The eviction time of the record, which in the statistics record table

- top_k_num: <code>pos_integer()</code>
  * default: 
  `10`

  The maximum number of records in the slow subscription statistics record table

- stats_type: <code>whole | internal | response</code>
  * default: 
  `whole`

  The method to calculate the latency


## statsd <a id='statsd'></a>
StatsD metrics collection and push configuration.


**Config paths**

 - <code>statsd</code>

**Env overrides**

 - <code>EMQX_STATSD</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable or disable StatsD metrics collection and push service.

- server: <code>emqx_schema:host_port()</code>
  * default: 
  `"127.0.0.1:8125"`

  StatsD server address.

- sample_time_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"30s"`

  The sampling interval for metrics.

- flush_time_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"30s"`

  The push interval for metrics.

- tags: <code>map()</code>
  * default: 
  `{}`

  The tags for metrics.


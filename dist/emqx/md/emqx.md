# EMQX

## Root Config Keys <a id='root-config-keys'></a>




**Fields**

- listeners: <code>[broker:listeners](#broker-listeners)</code>


- zones: <code>{$name -> [broker:zone](#broker-zone)}</code>
  A zone is a set of configs grouped by the zone <code>name</code>.
  For flexible configuration mapping, the <code>name</code> can be set to a listener's <code>zone</code> config.
  NOTE: A built-in zone named <code>default</code> is auto created and can not be deleted.

- mqtt: <code>[broker:mqtt](#broker-mqtt)</code>
  Global MQTT configuration.
  The configs here work as default values which can be overridden in <code>zone</code> configs

- authentication: <code>[[authn-builtin_db:authentication](authn.md#authn-builtin_db-authentication) | [authn-mysql:authentication](authn.md#authn-mysql-authentication) | [authn-postgresql:authentication](authn.md#authn-postgresql-authentication) | [authn-mongodb:standalone](authn.md#authn-mongodb-standalone) | [authn-mongodb:replica-set](authn.md#authn-mongodb-replica-set) | [authn-mongodb:sharded-cluster](authn.md#authn-mongodb-sharded-cluster) | [authn-redis:standalone](authn.md#authn-redis-standalone) | [authn-redis:cluster](authn.md#authn-redis-cluster) | [authn-redis:sentinel](authn.md#authn-redis-sentinel) | [authn-http:get](authn.md#authn-http-get) | [authn-http:post](authn.md#authn-http-post) | [authn-jwt:hmac-based](authn.md#authn-jwt-hmac-based) | [authn-jwt:public-key](authn.md#authn-jwt-public-key) | [authn-jwt:jwks](authn.md#authn-jwt-jwks) | [authn-scram-builtin_db:authentication](authn.md#authn-scram-builtin_db-authentication)]</code>
  Default authentication configs for all MQTT listeners.
  For per-listener overrides see <code>authentication</code> in listener configs
  This option can be configured with:
  <ul>
    <li><code>[]</code>: The default value, it allows *ALL* logins</li>
    <li>one: For example <code>{enable:true,backend:"built_in_database",mechanism="password_based"}</code></li>
    <li>chain: An array of structs.</li>
  </ul>
  When a chain is configured, the login credentials are checked against the backends per the configured order, until an 'allow' or 'deny' decision can be made.
  If there is no decision after a full chain exhaustion, the login is rejected.

- authorization: <code>[authorization](#authorization)</code>
  Authorization a.k.a. ACL.<br/>
  In EMQX, MQTT client access control is extremely flexible.<br/>
  An out-of-the-box set of authorization data sources are supported.
  For example,<br/>
  'file' source is to support concise and yet generic ACL rules in a file;<br/>
  'built_in_database' source can be used to store per-client customizable rule sets,
  natively in the EMQX node;<br/>
  'http' source to make EMQX call an external HTTP API to make the decision;<br/>
  'PostgreSQL' etc. to look up clients or rules from external databases;<br/>

- node: <code>[node](#node)</code>


- cluster: <code>[cluster](#cluster)</code>


- log: <code>[log](#log)</code>


- rpc: <code>[rpc](#rpc)</code>


- broker: <code>[broker](#broker)</code>
  Message broker options.

- sys_topics: <code>[broker:sys_topics](#broker-sys_topics)</code>
  System topics configuration.

- force_shutdown: <code>[broker:force_shutdown](#broker-force_shutdown)</code>


- overload_protection: <code>[broker:overload_protection](#broker-overload_protection)</code>


- force_gc: <code>[broker:force_gc](#broker-force_gc)</code>


- conn_congestion: <code>[broker:conn_congestion](#broker-conn_congestion)</code>


- stats: <code>[broker:stats](#broker-stats)</code>


- sysmon: <code>[broker:sysmon](#broker-sysmon)</code>


- alarm: <code>[broker:alarm](#broker-alarm)</code>


- flapping_detect: <code>[broker:flapping_detect](#broker-flapping_detect)</code>


- persistent_session_store: <code>[broker:persistent_session_store](#broker-persistent_session_store)</code>


- trace: <code>[broker:trace](#broker-trace)</code>


- bridges: <code>[bridge:bridges](bridges.md#bridge-bridges)</code>


- retainer: <code>[retainer](others.md#retainer)</code>


- statsd: <code>[statsd](others.md#statsd)</code>


- auto_subscribe: <code>[auto_subscribe](others.md#auto_subscribe)</code>


- delayed: <code>[modules:delayed](others.md#modules-delayed)</code>


- telemetry: <code>[modules:telemetry](others.md#modules-telemetry)</code>


- rewrite: <code>[[modules:rewrite](others.md#modules-rewrite)]</code>
  List of topic rewrite rules.

- topic_metrics: <code>[[modules:topic_metrics](others.md#modules-topic_metrics)]</code>
  List of topics whose metrics are reported.

- plugins: <code>[plugin:plugins](others.md#plugin-plugins)</code>


- dashboard: <code>[dashboard](others.md#dashboard)</code>


- gateway: <code>[gateway](gateway.md#gateway)</code>


- prometheus: <code>[prometheus](others.md#prometheus)</code>


- rule_engine: <code>[rule_engine](rule.md#rule_engine)</code>


- exhook: <code>[exhook](others.md#exhook)</code>


- psk_authentication: <code>[authn-psk:psk_authentication](others.md#authn-psk-psk_authentication)</code>


- limiter: <code>[limiter](others.md#limiter)</code>


- slow_subs: <code>[slow_subs](others.md#slow_subs)</code>



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

- limiter: <code>[limiter:listener_fields](others.md#limiter-listener_fields)</code>
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

- limiter: <code>[limiter:listener_fields](others.md#limiter-listener_fields)</code>
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

- limiter: <code>[limiter:listener_fields](others.md#limiter-listener_fields)</code>
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

- limiter: <code>[limiter:listener_fields](others.md#limiter-listener_fields)</code>
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

- limiter: <code>[limiter:listener_fields](others.md#limiter-listener_fields)</code>
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

- mqtt: <code>[zone:mqtt](others.md#zone-mqtt)</code>


- stats: <code>[zone:stats](others.md#zone-stats)</code>


- flapping_detect: <code>[zone:flapping_detect](others.md#zone-flapping_detect)</code>


- force_shutdown: <code>[zone:force_shutdown](others.md#zone-force_shutdown)</code>


- conn_congestion: <code>[zone:conn_congestion](others.md#zone-conn_congestion)</code>


- force_gc: <code>[zone:force_gc](others.md#zone-force_gc)</code>


- overload_protection: <code>[zone:overload_protection](others.md#zone-overload_protection)</code>



## cluster_dns <a id='cluster_dns'></a>
Service discovery via DNS SRV records.


**Config paths**

 - <code>cluster.dns</code>

**Env overrides**

 - <code>EMQX_CLUSTER__DNS</code>


**Fields**

- name: <code>string()</code>
  * default: 
  `"localhost"`

  The domain name from which to discover peer EMQX nodes' IP addresses.
  Applicable when <code>cluster.discovery_strategy = dns</code>

- record_type: <code>a | srv</code>
  * default: 
  `a`

  DNS record type. 


## cluster_etcd <a id='cluster_etcd'></a>
Service discovery using 'etcd' service.


**Config paths**

 - <code>cluster.etcd</code>

**Env overrides**

 - <code>EMQX_CLUSTER__ETCD</code>


**Fields**

- server: <code>emqx_schema:comma_separated_list()</code>
  List of endpoint URLs of the etcd cluster

- prefix: <code>string()</code>
  * default: 
  `"emqxcl"`

  Key prefix used for EMQX service discovery.

- node_ttl: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  Expiration time of the etcd key associated with the node.
  It is refreshed automatically, as long as the node is alive.
            

- ssl: <code>[broker:ssl_client_opts](#broker-ssl_client_opts)</code>
  Options for the TLS connection to the etcd cluster.


## cluster_k8s <a id='cluster_k8s'></a>
Service discovery via Kubernetes API server.


**Config paths**

 - <code>cluster.k8s</code>

**Env overrides**

 - <code>EMQX_CLUSTER__K8S</code>


**Fields**

- apiserver: <code>string()</code>
  * default: 
  `"http://10.110.111.204:8080"`

  Kubernetes API endpoint URL.

- service_name: <code>string()</code>
  * default: 
  `"emqx"`

  EMQX broker service name.

- address_type: <code>ip | dns | hostname</code>
  * default: 
  `ip`

  Address type used for connecting to the discovered nodes.
  Setting <code>cluster.k8s.address_type</code> to <code>ip</code> will
  make EMQX to discover IP addresses of peer nodes from Kubernetes API.

- namespace: <code>string()</code>
  * default: 
  `"default"`

  Kubernetes namespace.

- suffix: <code>string()</code>
  * default: 
  `"pod.local"`

  Node name suffix.<br/>
  Note: this parameter is only relevant when <code>address_type</code> is <code>dns</code>
  or <code>hostname</code>.


## cluster_mcast <a id='cluster_mcast'></a>
Service discovery via UDP multicast.


**Config paths**

 - <code>cluster.mcast</code>

**Env overrides**

 - <code>EMQX_CLUSTER__MCAST</code>


**Fields**

- addr: <code>string()</code>
  * default: 
  `"239.192.0.1"`

  Multicast IPv4 address.

- ports: <code>[integer()]</code>
  * default: 
  `[4369,4370]`

  List of UDP ports used for service discovery.<br/>
  Note: probe messages are broadcast to all the specified ports.
            

- iface: <code>string()</code>
  * default: 
  `"0.0.0.0"`

  Local IP address the node discovery service needs to bind to.

- ttl: <code>0..255</code>
  * default: 
  `255`

  Time-to-live (TTL) for the outgoing UDP datagrams.

- loop: <code>boolean()</code>
  * default: 
  `true`

  If <code>true</code>, loop UDP datagrams back to the local socket.

- sndbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"16KB"`

  Size of the kernel-level buffer for outgoing datagrams.

- recbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"16KB"`

  Size of the kernel-level buffer for incoming datagrams.

- buffer: <code>emqx_schema:bytesize()</code>
  * default: 
  `"32KB"`

  Size of the user-level buffer.


## cluster_static <a id='cluster_static'></a>
Service discovery via static nodes.
The new node joins the cluster by connecting to one of the bootstrap nodes.


**Config paths**

 - <code>cluster.static</code>

**Env overrides**

 - <code>EMQX_CLUSTER__STATIC</code>


**Fields**

- seeds: <code>[atom()]</code>
  * default: 
  `[]`

  List EMQX node names in the static cluster. See <code>node.name</code>.


## authorization <a id='authorization'></a>
Settings that control client authorization.


**Config paths**

 - <code>authorization</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION</code>


**Fields**

- no_match: <code>allow | deny</code>
  * default: 
  `allow`

  Default access control action if the user or client matches no ACL rules,
  or if no such user or client is found by the configurable authorization
  sources such as built_in_database, an HTTP API, or a query against PostgreSQL.
  Find more details in 'authorization.sources' config.

- deny_action: <code>ignore | disconnect</code>
  * default: 
  `ignore`

  The action when the authorization check rejects an operation.

- cache: <code>[broker:cache](#broker-cache)</code>


- sources: <code>[[authz:file](authz.md#authz-file) | [authz:http_get](authz.md#authz-http_get) | [authz:http_post](authz.md#authz-http_post) | [authz:mnesia](authz.md#authz-mnesia) | [authz:mongo_single](authz.md#authz-mongo_single) | [authz:mongo_rs](authz.md#authz-mongo_rs) | [authz:mongo_sharded](authz.md#authz-mongo_sharded) | [authz:mysql](authz.md#authz-mysql) | [authz:postgresql](authz.md#authz-postgresql) | [authz:redis_single](authz.md#authz-redis_single) | [authz:redis_sentinel](authz.md#authz-redis_sentinel) | [authz:redis_cluster](authz.md#authz-redis_cluster)]</code>
  * default: 
  `[]`

  Authorization data sources.<br/>
  An array of authorization (ACL) data providers.
  It is designed as an array, not a hash-map, so the sources can be
  ordered to form a chain of access controls.<br/>
  When authorizing a 'publish' or 'subscribe' action, the configured
  sources are checked in order. When checking an ACL source,
  in case the client (identified by username or client ID) is not found,
  it moves on to the next source. And it stops immediately
  once an 'allow' or 'deny' decision is returned.<br/>
  If the client is not found in any of the sources,
  the default action configured in 'authorization.no_match' is applied.<br/>
  NOTE:
  The source elements are identified by their 'type'.
  It is NOT allowed to configure two or more sources of the same type.


## cluster <a id='cluster'></a>
EMQX nodes can form a cluster to scale up the total capacity.<br/>
      Here holds the configs to instruct how individual nodes can discover each other.


**Config paths**

 - <code>cluster</code>

**Env overrides**

 - <code>EMQX_CLUSTER</code>


**Fields**

- name: <code>atom()</code>
  * default: 
  `emqxcl`

  * mapping: 
  `ekka.cluster_name`

  Human-friendly name of the EMQX cluster.

- discovery_strategy: <code>manual | static | mcast | dns | etcd | k8s</code>
  * default: 
  `manual`

  Service discovery method for the cluster nodes.

- core_nodes: <code>emqx_schema:comma_separated_atoms()</code>
  * default: 
  `[]`

  * mapping: 
  `mria.core_nodes`

  List of core nodes that the replicant will connect to.<br/>
  Note: this parameter only takes effect when the <code>backend</code> is set
  to <code>rlog</code> and the <code>role</code> is set to <code>replicant</code>.<br/>
  This value needs to be defined for manual or static cluster discovery mechanisms.<br/>
  If an automatic cluster discovery mechanism is being used (such as <code>etcd</code>),
  there is no need to set this value.

- autoclean: <code>emqx_schema:duration()</code>
  * default: 
  `"5m"`

  * mapping: 
  `ekka.cluster_autoclean`

  Remove disconnected nodes from the cluster after this interval.

- autoheal: <code>boolean()</code>
  * default: 
  `true`

  * mapping: 
  `ekka.cluster_autoheal`

  If <code>true</code>, the node will try to heal network partitions automatically.

- proto_dist: <code>inet_tcp | inet6_tcp | inet_tls</code>
  * default: 
  `inet_tcp`

  * mapping: 
  `ekka.proto_dist`

  The Erlang distribution protocol for the cluster.

- static: <code>[cluster_static](#cluster_static)</code>


- mcast: <code>[cluster_mcast](#cluster_mcast)</code>


- dns: <code>[cluster_dns](#cluster_dns)</code>


- etcd: <code>[cluster_etcd](#cluster_etcd)</code>


- k8s: <code>[cluster_k8s](#cluster_k8s)</code>



## cluster_call <a id='cluster_call'></a>
Options for the 'cluster call' feature that allows to execute a callback on all nodes in the cluster.


**Config paths**

 - <code>node.cluster_call</code>

**Env overrides**

 - <code>EMQX_NODE__CLUSTER_CALL</code>


**Fields**

- retry_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"1m"`

  Time interval to retry after a failed call.

- max_history: <code>1..500</code>
  * default: 
  `100`

  Retain the maximum number of completed transactions (for queries).

- cleanup_interval: <code>emqx_schema:duration()</code>
  * default: 
  `"5m"`

  Time interval to clear completed but stale transactions.
  Ensure that the number of completed transactions is less than the <code>max_history</code>.


## console_handler <a id='console_handler'></a>
Log handler that prints log events to the EMQX console.


**Config paths**

 - <code>log.console_handler</code>

**Env overrides**

 - <code>EMQX_LOG__CONSOLE_HANDLER</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `false`

  Enable this log handler.

- level: <code>emqx_conf_schema:log_level()</code>
  * default: 
  `warning`

  The log level for the current log handler.
  Defaults to warning.

- time_offset: <code>string()</code>
  * default: 
  `"system"`

  The time offset to be used when formatting the timestamp.
  Can be one of:
    - <code>system</code>: the time offset used by the local system
    - <code>utc</code>: the UTC time offset
    - <code>+-[hh]:[mm]</code>: user specified time offset, such as "-02:00" or "+00:00"
  Defaults to: <code>system</code>.

- chars_limit: <code>unlimited | 100..inf</code>
  * default: 
  `unlimited`

  Set the maximum length of a single log message. If this length is exceeded, the log message will be truncated.
  NOTE: Restrict char limiter if formatter is JSON , it will get a truncated incomplete JSON data, which is not recommended.

- formatter: <code>text | json</code>
  * default: 
  `text`

  Choose log formatter. <code>text</code> for free text, and <code>json</code> for structured logging.

- single_line: <code>boolean()</code>
  * default: 
  `true`

  Print logs in a single line if set to true. Otherwise, log messages may span multiple lines.

- sync_mode_qlen: <code>non_neg_integer()</code>
  * default: 
  `100`

  As long as the number of buffered log events is lower than this value,
  all log events are handled asynchronously. This means that the client process sending the log event,
  by calling a log function in the Logger API, does not wait for a response from the handler
  but continues executing immediately after the event is sent.
  It is not affected by the time it takes the handler to print the event to the log device.
  If the message queue grows larger than this value,
  the handler starts handling log events synchronously instead,
  meaning that the client process sending the event must wait for a response.
  When the handler reduces the message queue to a level below the sync_mode_qlen threshold,
  asynchronous operation is resumed.

- drop_mode_qlen: <code>pos_integer()</code>
  * default: 
  `3000`

  When the number of buffered log events is larger than this value, the new log events are dropped.
  When drop mode is activated or deactivated, a message is printed in the logs.

- flush_qlen: <code>pos_integer()</code>
  * default: 
  `8000`

  If the number of buffered log events grows larger than this threshold, a flush (delete) operation takes place.
  To flush events, the handler discards the buffered log messages without logging.

- overload_kill: <code>[log_overload_kill](#log_overload_kill)</code>


- burst_limit: <code>[log_burst_limit](#log_burst_limit)</code>


- supervisor_reports: <code>error | progress</code>
  * default: 
  `error`

  Type of supervisor reports that are logged. Defaults to <code>error</code>
    - <code>error</code>: only log errors in the Erlang processes.
    - <code>progress</code>: log process startup.

- max_depth: <code>unlimited | non_neg_integer()</code>
  * default: 
  `100`

  Maximum depth for Erlang term log formatting and Erlang process message queue inspection.


## log <a id='log'></a>
EMQX logging supports multiple sinks for the log events.
Each sink is represented by a _log handler_, which can be configured independently.


**Config paths**

 - <code>log</code>

**Env overrides**

 - <code>EMQX_LOG</code>


**Fields**

- console_handler: <code>[console_handler](#console_handler)</code>


- file_handlers: <code>{$name -> [log_file_handler](#log_file_handler)}</code>
  File-based log handlers.


## log_burst_limit <a id='log_burst_limit'></a>
Large bursts of log events produced in a short time can potentially cause problems, such as:
 - Log files grow very large
 - Log files are rotated too quickly, and useful information gets overwritten
 - Overall performance impact on the system

Log burst limit feature can temporarily disable logging to avoid these issues.


**Config paths**

 - <code>log.console_handler.burst_limit</code>
 - <code>log.file_handlers.$name.burst_limit</code>

**Env overrides**

 - <code>EMQX_LOG__CONSOLE_HANDLER__BURST_LIMIT</code>
 - <code>EMQX_LOG__FILE_HANDLERS__$NAME__BURST_LIMIT</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable log burst control feature.

- max_count: <code>pos_integer()</code>
  * default: 
  `10000`

  Maximum number of log events to handle within a `window_time` interval. After the limit is reached, successive events are dropped until the end of the `window_time`.

- window_time: <code>emqx_schema:duration()</code>
  * default: 
  `"1s"`

  See <code>max_count</code>.


## log_file_handler <a id='log_file_handler'></a>
Log handler that prints log events to files.


**Config paths**

 - <code>log.file_handlers.$name</code>

**Env overrides**

 - <code>EMQX_LOG__FILE_HANDLERS__$NAME</code>


**Fields**

- file: <code>emqx_conf_schema:file()</code>
  Name the log file.

- rotation: <code>[log_rotation](#log_rotation)</code>


- max_size: <code>infinity | emqx_schema:bytesize()</code>
  * default: 
  `"50MB"`

  This parameter controls log file rotation. The value `infinity` means the log file will grow indefinitely, otherwise the log file will be rotated once it reaches `max_size` in bytes.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable this log handler.

- level: <code>emqx_conf_schema:log_level()</code>
  * default: 
  `warning`

  The log level for the current log handler.
  Defaults to warning.

- time_offset: <code>string()</code>
  * default: 
  `"system"`

  The time offset to be used when formatting the timestamp.
  Can be one of:
    - <code>system</code>: the time offset used by the local system
    - <code>utc</code>: the UTC time offset
    - <code>+-[hh]:[mm]</code>: user specified time offset, such as "-02:00" or "+00:00"
  Defaults to: <code>system</code>.

- chars_limit: <code>unlimited | 100..inf</code>
  * default: 
  `unlimited`

  Set the maximum length of a single log message. If this length is exceeded, the log message will be truncated.
  NOTE: Restrict char limiter if formatter is JSON , it will get a truncated incomplete JSON data, which is not recommended.

- formatter: <code>text | json</code>
  * default: 
  `text`

  Choose log formatter. <code>text</code> for free text, and <code>json</code> for structured logging.

- single_line: <code>boolean()</code>
  * default: 
  `true`

  Print logs in a single line if set to true. Otherwise, log messages may span multiple lines.

- sync_mode_qlen: <code>non_neg_integer()</code>
  * default: 
  `100`

  As long as the number of buffered log events is lower than this value,
  all log events are handled asynchronously. This means that the client process sending the log event,
  by calling a log function in the Logger API, does not wait for a response from the handler
  but continues executing immediately after the event is sent.
  It is not affected by the time it takes the handler to print the event to the log device.
  If the message queue grows larger than this value,
  the handler starts handling log events synchronously instead,
  meaning that the client process sending the event must wait for a response.
  When the handler reduces the message queue to a level below the sync_mode_qlen threshold,
  asynchronous operation is resumed.

- drop_mode_qlen: <code>pos_integer()</code>
  * default: 
  `3000`

  When the number of buffered log events is larger than this value, the new log events are dropped.
  When drop mode is activated or deactivated, a message is printed in the logs.

- flush_qlen: <code>pos_integer()</code>
  * default: 
  `8000`

  If the number of buffered log events grows larger than this threshold, a flush (delete) operation takes place.
  To flush events, the handler discards the buffered log messages without logging.

- overload_kill: <code>[log_overload_kill](#log_overload_kill)</code>


- burst_limit: <code>[log_burst_limit](#log_burst_limit)</code>


- supervisor_reports: <code>error | progress</code>
  * default: 
  `error`

  Type of supervisor reports that are logged. Defaults to <code>error</code>
    - <code>error</code>: only log errors in the Erlang processes.
    - <code>progress</code>: log process startup.

- max_depth: <code>unlimited | non_neg_integer()</code>
  * default: 
  `100`

  Maximum depth for Erlang term log formatting and Erlang process message queue inspection.


## log_overload_kill <a id='log_overload_kill'></a>

Log overload kill features an overload protection that activates when the log handlers use too much memory or have too many buffered log messages.<br/>
When the overload is detected, the log handler is terminated and restarted after a cooldown period.



**Config paths**

 - <code>log.console_handler.overload_kill</code>
 - <code>log.file_handlers.$name.overload_kill</code>

**Env overrides**

 - <code>EMQX_LOG__CONSOLE_HANDLER__OVERLOAD_KILL</code>
 - <code>EMQX_LOG__FILE_HANDLERS__$NAME__OVERLOAD_KILL</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable log handler overload kill feature.

- mem_size: <code>emqx_schema:bytesize()</code>
  * default: 
  `"30MB"`

  Maximum memory size that the log handler process is allowed to use.

- qlen: <code>pos_integer()</code>
  * default: 
  `20000`

  Maximum allowed queue length.

- restart_after: <code>emqx_schema:duration_ms() | infinity</code>
  * default: 
  `"5s"`

  If the handler is terminated, it restarts automatically after a delay specified in milliseconds. The value `infinity` prevents restarts.


## log_rotation <a id='log_rotation'></a>

By default, the logs are stored in `./log` directory (for installation from zip file) or in `/var/log/emqx` (for binary installation).<br/>
This section of the configuration controls the number of files kept for each log handler.



**Config paths**

 - <code>log.file_handlers.$name.rotation</code>

**Env overrides**

 - <code>EMQX_LOG__FILE_HANDLERS__$NAME__ROTATION</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable log rotation feature.

- count: <code>1..2048</code>
  * default: 
  `10`

  Maximum number of log files.


## node <a id='node'></a>
Node name, cookie, config & data directories and the Erlang virtual machine (BEAM) boot parameters.


**Config paths**

 - <code>node</code>

**Env overrides**

 - <code>EMQX_NODE</code>


**Fields**

- name: <code>string()</code>
  * default: 
  `"emqx@127.0.0.1"`

  Unique name of the EMQX node. It must follow <code>%name%@FQDN</code> or
  <code>%name%@IPv4</code> format.
            

- cookie: <code>string()</code>
  * mapping: 
  `vm_args.-setcookie`

  Secret cookie is a random string that should be the same on all nodes in
  the given EMQX cluster, but unique per EMQX cluster. It is used to prevent EMQX nodes that
  belong to different clusters from accidentally connecting to each other.

- process_limit: <code>1024..134217727</code>
  * default: 
  `2097152`

  * mapping: 
  `vm_args.+P`

  Maximum number of simultaneously existing processes for this Erlang system.
  The actual maximum chosen may be much larger than the Number passed.
  For more information, see: https://www.erlang.org/doc/man/erl.html
            

- max_ports: <code>1024..134217727</code>
  * default: 
  `1048576`

  * mapping: 
  `vm_args.+Q`

  Maximum number of simultaneously existing ports for this Erlang system.
  The actual maximum chosen may be much larger than the Number passed.
  For more information, see: https://www.erlang.org/doc/man/erl.html
            

- dist_buffer_size: <code>1..2097151</code>
  * default: 
  `8192`

  * mapping: 
  `vm_args.+zdbbl`

  Erlang's distribution buffer busy limit in kilobytes.

- max_ets_tables: <code>pos_integer()</code>
  * default: 
  `262144`

  * mapping: 
  `vm_args.+e`

  Max number of ETS tables

- data_dir: <code>string()</code>
  * mapping: 
  `emqx.data_dir`

  Path to the persistent data directory.<br/>
  Possible auto-created subdirectories are:<br/>
  - `mnesia/<node_name>`: EMQX's built-in database directory.<br/>
  For example, `mnesia/emqx@127.0.0.1`.<br/>
  There should be only one such subdirectory.<br/>
  Meaning, in case the node is to be renamed (to e.g. `emqx@10.0.1.1`),<br/>
  the old dir should be deleted first.<br/>
  - `configs`: Generated configs at boot time, and cluster/local override configs.<br/>
  - `patches`: Hot-patch beam files are to be placed here.<br/>
  - `trace`: Trace log files.<br/>
  **NOTE**: One data dir cannot be shared by two or more EMQX nodes.

- config_files: <code>[string()]</code>
  * mapping: 
  `emqx.config_files`

  List of configuration files that are read during startup. The order is
  significant: later configuration files override the previous ones.
            

- global_gc_interval: <code>disabled | emqx_schema:duration()</code>
  * default: 
  `"15m"`

  * mapping: 
  `emqx_machine.global_gc_interval`

  Periodic garbage collection interval. Set to <code>disabled</code> to have it disabled.

- crash_dump_file: <code>emqx_conf_schema:file()</code>
  * default: 
  `"log/erl_crash.dump"`

  * mapping: 
  `vm_args.-env ERL_CRASH_DUMP`

  Location of the crash dump file.

- crash_dump_seconds: <code>emqx_schema:duration_s()</code>
  * default: 
  `"30s"`

  * mapping: 
  `vm_args.-env ERL_CRASH_DUMP_SECONDS`

  The number of seconds that the broker is allowed to spend writing a crash dump.

- crash_dump_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  * mapping: 
  `vm_args.-env ERL_CRASH_DUMP_BYTES`

  The maximum size of a crash dump file in bytes.

- dist_net_ticktime: <code>emqx_schema:duration_s()</code>
  * default: 
  `"2m"`

  * mapping: 
  `vm_args.-kernel net_ticktime`

  This is the approximate time an EMQX node may be unresponsive until it is considered down and thereby disconnected.

- backtrace_depth: <code>integer()</code>
  * default: 
  `23`

  * mapping: 
  `emqx_machine.backtrace_depth`

  Maximum depth of the call stack printed in error messages and
  <code>process_info</code>.
            

- applications: <code>emqx_schema:comma_separated_atoms()</code>
  * default: 
  `[]`

  * mapping: 
  `emqx_machine.applications`

  List of Erlang applications that shall be rebooted when the EMQX broker joins the cluster.
            

- etc_dir: <code>string()</code>
  Deprecated since 5.0.8.

- cluster_call: <code>[cluster_call](#cluster_call)</code>


- db_backend: <code>mnesia | rlog</code>
  * default: 
  `rlog`

  * mapping: 
  `mria.db_backend`

  Select the backend for the embedded database.<br/>
  <code>rlog</code> is the default backend,
  that is suitable for very large clusters.<br/>
  <code>mnesia</code> is a backend that offers decent performance in small clusters.

- db_role: <code>core | replicant</code>
  * default: 
  `core`

  * mapping: 
  `mria.node_role`

  Select a node role.<br/>
  <code>core</code> nodes provide durability of the data, and take care of writes.
  It is recommended to place core nodes in different racks or different availability zones.<br/>
  <code>replicant</code> nodes are ephemeral worker nodes. Removing them from the cluster
  doesn't affect database redundancy<br/>
  It is recommended to have more replicant nodes than core nodes.<br/>
  Note: this parameter only takes effect when the <code>backend</code> is set
  to <code>rlog</code>.

- rpc_module: <code>gen_rpc | rpc</code>
  * default: 
  `gen_rpc`

  * mapping: 
  `mria.rlog_rpc_module`

  Protocol used for pushing transaction logs to the replicant nodes.

- tlog_push_mode: <code>sync | async</code>
  * default: 
  `async`

  * mapping: 
  `mria.tlog_push_mode`

  In sync mode the core node waits for an ack from the replicant nodes before sending the next
  transaction log entry.


## rpc <a id='rpc'></a>
EMQX uses a library called <code>gen_rpc</code> for inter-broker communication.<br/>
Most of the time the default config should work,
but in case you need to do performance fine-tuning or experiment a bit,
this is where to look.


**Config paths**

 - <code>rpc</code>

**Env overrides**

 - <code>EMQX_RPC</code>


**Fields**

- mode: <code>sync | async</code>
  * default: 
  `async`

  In <code>sync</code> mode the sending side waits for the ack from the receiving side.

- driver: <code>tcp | ssl</code>
  * default: 
  `tcp`

  * mapping: 
  `gen_rpc.driver`

  Transport protocol used for inter-broker communication

- async_batch_size: <code>integer()</code>
  * default: 
  `256`

  * mapping: 
  `gen_rpc.max_batch_size`

  The maximum number of batch messages sent in asynchronous mode.
        Note that this configuration does not work in synchronous mode.
        

- port_discovery: <code>manual | stateless</code>
  * default: 
  `stateless`

  * mapping: 
  `gen_rpc.port_discovery`

  <code>manual</code>: discover ports by <code>tcp_server_port</code>.<br/>
  <code>stateless</code>: discover ports in a stateless manner, using the following algorithm.
  If node name is <code>emqxN@127.0.0.1</code>, where the N is an integer,
  then the listening port will be 5370 + N.

- tcp_server_port: <code>integer()</code>
  * default: 
  `5369`

  * mapping: 
  `gen_rpc.tcp_server_port`

  Listening port used by RPC local service.<br/>
  Note that this config only takes effect when rpc.port_discovery is set to manual.

- ssl_server_port: <code>integer()</code>
  * default: 
  `5369`

  * mapping: 
  `gen_rpc.ssl_server_port`

  Listening port used by RPC local service.<br/>
  Note that this config only takes effect when rpc.port_discovery is set to manual
  and <code>driver</code> is set to <code>ssl</code>.

- tcp_client_num: <code>1..256</code>
  * default: 
  `10`

  Set the maximum number of RPC communication channels initiated by this node to each remote node.

- connect_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  * mapping: 
  `gen_rpc.connect_timeout`

  Timeout for establishing an RPC connection.

- certfile: <code>emqx_conf_schema:file()</code>
  * mapping: 
  `gen_rpc.certfile`

  Path to TLS certificate file used to validate identity of the cluster nodes.
  Note that this config only takes effect when <code>rpc.driver</code> is set to <code>ssl</code>.
        

- keyfile: <code>emqx_conf_schema:file()</code>
  * mapping: 
  `gen_rpc.keyfile`

  Path to the private key file for the <code>rpc.certfile</code>.<br/>
  Note: contents of this file are secret, so it's necessary to set permissions to 600.

- cacertfile: <code>emqx_conf_schema:file()</code>
  * mapping: 
  `gen_rpc.cacertfile`

  Path to certification authority TLS certificate file used to validate <code>rpc.certfile</code>.<br/>
  Note: certificates of all nodes in the cluster must be signed by the same CA.

- send_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  * mapping: 
  `gen_rpc.send_timeout`

  Timeout for sending the RPC request.

- authentication_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"5s"`

  * mapping: 
  `gen_rpc.authentication_timeout`

  Timeout for the remote node authentication.

- call_receive_timeout: <code>emqx_schema:duration()</code>
  * default: 
  `"15s"`

  * mapping: 
  `gen_rpc.call_receive_timeout`

  Timeout for the reply to a synchronous RPC.

- socket_keepalive_idle: <code>emqx_schema:duration_s()</code>
  * default: 
  `"15m"`

  * mapping: 
  `gen_rpc.socket_keepalive_idle`

  How long the connections between the brokers should remain open after the last message is sent.

- socket_keepalive_interval: <code>emqx_schema:duration_s()</code>
  * default: 
  `"75s"`

  * mapping: 
  `gen_rpc.socket_keepalive_interval`

  The interval between keepalive messages.

- socket_keepalive_count: <code>integer()</code>
  * default: 
  `9`

  * mapping: 
  `gen_rpc.socket_keepalive_count`

  How many times the keepalive probe message can fail to receive a reply
  until the RPC connection is considered lost.

- socket_sndbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  * mapping: 
  `gen_rpc.socket_sndbuf`

  TCP tuning parameters. TCP sending buffer size.

- socket_recbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  * mapping: 
  `gen_rpc.socket_recbuf`

  TCP tuning parameters. TCP receiving buffer size.

- socket_buffer: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1MB"`

  * mapping: 
  `gen_rpc.socket_buffer`

  TCP tuning parameters. Socket buffer size in user mode.

- insecure_fallback: <code>boolean()</code>
  * default: 
  `true`

  * mapping: 
  `gen_rpc.insecure_auth_fallback_allowed`

  Enable compatibility with old RPC authentication.


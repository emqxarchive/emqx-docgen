# Other Configurations

## connector_hstreamdb:config <a id='connector_hstreamdb-config'></a>
HStreamDB connection config


**Config paths**

 - <code>bridges.hstreamdb.$name.connector</code>

**Env overrides**

 - <code>EMQX_BRIDGES__HSTREAMDB__$NAME__CONNECTOR</code>


**Fields**

- url: <code>binary()</code>
  HStreamDB Server URL

- stream: <code>binary()</code>
  HStreamDB Stream Name

- ordering_key: <code>binary()</code>
  HStreamDB Ordering Key

- pool_size: <code>pos_integer()</code>
  HStreamDB Pool Size


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
 - <code>bridges.mongodb_rs.$name.topology</code>
 - <code>bridges.mongodb_sharded.$name.topology</code>
 - <code>bridges.mongodb_single.$name.topology</code>
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
 - <code>EMQX_BRIDGES__MONGODB_RS__$NAME__TOPOLOGY</code>
 - <code>EMQX_BRIDGES__MONGODB_SHARDED__$NAME__TOPOLOGY</code>
 - <code>EMQX_BRIDGES__MONGODB_SINGLE__$NAME__TOPOLOGY</code>
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


## bridge_gcp_pubsub:config <a id='bridge_gcp_pubsub-config'></a>
Configuration for a GCP PubSub bridge.


**Config paths**

 - <code>bridges.gcp_pubsub.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__GCP_PUBSUB__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- connect_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  The timeout when connecting to the HTTP server.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  The pool size.

- pipelining: <code>pos_integer()</code>
  * default: 
  `100`

  A positive integer. Whether to send HTTP requests continuously, when set to 1, it means that after each HTTP request is sent, you need to wait for the server to return and then continue to send the next request.

- max_retries: <code>non_neg_integer()</code>
  * default: 
  `2`

  Max retry times if an error occurs when sending a request.

- request_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  HTTP request timeout.

- payload_template: <code>binary()</code>
  * default: 
  `""`

  The template for formatting the outgoing messages.  If undefined, will send all the available context in JSON format.

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to GCP PubSub. All MQTT 'PUBLISH' messages with the topic
  matching `local_topic` will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- pubsub_topic: <code>binary()</code>
  The GCP PubSub topic to publish messages to.

- service_account_json: <code>emqx_ee_bridge_gcp_pubsub:service_account_json()</code>
  JSON containing the GCP Service Account credentials to be used with PubSub.
  When a GCP Service Account is created (as described in https://developers.google.com/identity/protocols/oauth2/service-account#creatinganaccount), you have the option of downloading the credentials in JSON form.  That's the file needed.


## bridge_hstreamdb:config <a id='bridge_hstreamdb-config'></a>
Configuration for an HStreamDB bridge.


**Config paths**

 - <code>bridges.hstreamdb.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__HSTREAMDB__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- direction: <code>egress</code>
  * default: 
  `egress`

  The direction of this bridge, MUST be 'egress'

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to the HStreamDB. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- payload: <code>binary()</code>
  * default: 
  `"${payload}"`

  The payload to be forwarded to the HStreamDB. Placeholders supported.

- connector: <code>binary() | [connector_hstreamdb:config](#connector_hstreamdb-config)</code>
  Generic configuration for the connector.


## bridge_influxdb:influxdb_api_v1 <a id='bridge_influxdb-influxdb_api_v1'></a>
InfluxDB's protocol. Support InfluxDB v1.8 and before.


**Config paths**

 - <code>bridges.influxdb_api_v1.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__INFLUXDB_API_V1__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to the InfluxDB. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- write_syntax: <code>emqx_ee_bridge_influxdb:write_syntax()</code>
  Conf of InfluxDB line protocol to write data points. It is a text-based format that provides the measurement, tag set, field set, and timestamp of a data point, and placeholder supported.
  See also [InfluxDB 2.3 Line Protocol](https://docs.influxdata.com/influxdb/v2.3/reference/syntax/line-protocol/) and
  [InfluxDB 1.8 Line Protocol](https://docs.influxdata.com/influxdb/v1.8/write_protocols/line_protocol_tutorial/) </br>
  TLDR:</br>
  ```
  <measurement>[,<tag_key>=<tag_value>[,<tag_key>=<tag_value>]] <field_key>=<field_value>[,<field_key>=<field_value>] [<timestamp>]
  ```

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- server: <code>emqx_schema:ip_port()</code>
  * default: 
  `"127.0.0.1:8086"`

  The IPv4 or IPv6 address or the hostname to connect to.</br>
  A host entry has the following form: `Host[:Port]`.</br>
  The InfluxDB default port 8086 is used if `[:Port]` is not specified.

- precision: <code>ns | us | ms | s | m | h</code>
  * default: 
  `ms`

  InfluxDB time precision.

- database: <code>binary()</code>
  InfluxDB database.

- username: <code>binary()</code>
  InfluxDB username.

- password: <code>binary()</code>
  InfluxDB password.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_influxdb:influxdb_api_v2 <a id='bridge_influxdb-influxdb_api_v2'></a>
InfluxDB's protocol. Support InfluxDB v2.0 and after.


**Config paths**

 - <code>bridges.influxdb_api_v2.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__INFLUXDB_API_V2__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to the InfluxDB. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- write_syntax: <code>emqx_ee_bridge_influxdb:write_syntax()</code>
  Conf of InfluxDB line protocol to write data points. It is a text-based format that provides the measurement, tag set, field set, and timestamp of a data point, and placeholder supported.
  See also [InfluxDB 2.3 Line Protocol](https://docs.influxdata.com/influxdb/v2.3/reference/syntax/line-protocol/) and
  [InfluxDB 1.8 Line Protocol](https://docs.influxdata.com/influxdb/v1.8/write_protocols/line_protocol_tutorial/) </br>
  TLDR:</br>
  ```
  <measurement>[,<tag_key>=<tag_value>[,<tag_key>=<tag_value>]] <field_key>=<field_value>[,<field_key>=<field_value>] [<timestamp>]
  ```

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- server: <code>emqx_schema:ip_port()</code>
  * default: 
  `"127.0.0.1:8086"`

  The IPv4 or IPv6 address or the hostname to connect to.</br>
  A host entry has the following form: `Host[:Port]`.</br>
  The InfluxDB default port 8086 is used if `[:Port]` is not specified.

- precision: <code>ns | us | ms | s | m | h</code>
  * default: 
  `ms`

  InfluxDB time precision.

- bucket: <code>binary()</code>
  InfluxDB bucket name.

- org: <code>binary()</code>
  Organization name of InfluxDB.

- token: <code>binary()</code>
  InfluxDB token.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_kafka:auth_gssapi_kerberos <a id='bridge_kafka-auth_gssapi_kerberos'></a>
Use GSSAPI/Kerberos authentication.


**Config paths**

 - <code>bridges.kafka.$name.authentication</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__AUTHENTICATION</code>


**Fields**

- kerberos_principal: <code>binary()</code>
  SASL GSSAPI authentication Kerberos principal. For example <code>client_name@MY.KERBEROS.REALM.MYDOMAIN.COM</code>, NOTE: The realm in use has to be configured in /etc/krb5.conf in EMQX nodes.

- kerberos_keytab_file: <code>binary()</code>
  SASL GSSAPI authentication Kerberos keytab file path. NOTE: This file has to be placed in EMQX nodes, and the EMQX service runner user requires read permission.


## bridge_kafka:auth_username_password <a id='bridge_kafka-auth_username_password'></a>
Username/password based authentication.


**Config paths**

 - <code>bridges.kafka.$name.authentication</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__AUTHENTICATION</code>


**Fields**

- mechanism: <code>plain | scram_sha_256 | scram_sha_512</code>
  SASL authentication mechanism.

- username: <code>binary()</code>
  SASL authentication username.

- password: <code>binary()</code>
  SASL authentication password.


## bridge_kafka:kafka_message <a id='bridge_kafka-kafka_message'></a>
Template to render a Kafka message.


**Config paths**

 - <code>bridges.kafka.$name.producer.kafka.message</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__PRODUCER__KAFKA__MESSAGE</code>


**Fields**

- key: <code>string()</code>
  * default: 
  `"${clientid}"`

  Template to render Kafka message key. If the desired variable for this template is not found in the input data <code>NULL</code> is used.

- value: <code>string()</code>
  * default: 
  `"${payload}"`

  Template to render Kafka message value. If the desired variable for this template is not found in the input data <code>NULL</code> is used.

- timestamp: <code>string()</code>
  * default: 
  `"${timestamp}"`

  Which timestamp to use. The timestamp is expected to be a millisecond precision Unix epoch which can be in string format, e.g. <code>1661326462115</code> or <code>'1661326462115'</code>. When the desired data field for this template is not found, or if the found data is not a valid integer, the current system timestamp will be used.


## bridge_kafka:producer_buffer <a id='bridge_kafka-producer_buffer'></a>
Configure producer message buffer.

Tell Kafka producer how to buffer messages when EMQX has more messages to send than Kafka can keep up, or when Kafka is down.




**Config paths**

 - <code>bridges.kafka.$name.producer.kafka.buffer</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__PRODUCER__KAFKA__BUFFER</code>


**Fields**

- mode: <code>memory | disk | hybrid</code>
  * default: 
  `memory`

  Message buffer mode.
  <code>memory</code>: Buffer all messages in memory. The messages will be lost in case of EMQX node restart
  <code>disc</code>: Buffer all messages on disk. The messages on disk are able to survive EMQX node restart.
  <code>hybrid</code>: Buffer message in memory first, when up to certain limit (see <code>segment_bytes</code> config for more information), then start offloading messages to disk, Like <code>memory</code> mode, the messages will be lost in case of EMQX node restart.

- per_partition_limit: <code>emqx_schema:bytesize()</code>
  * default: 
  `"2GB"`

  Number of bytes allowed to buffer for each Kafka partition. When this limit is exceeded, old messages will be dropped in a trade for credits for new messages to be buffered.

- segment_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  Applicable when buffer mode is set to <code>disk</code> or <code>hybrid</code>.
  This value is to specify the size of each on-disk buffer file.

- memory_overload_protection: <code>boolean()</code>
  * default: 
  `true`

  Applicable when buffer mode is set to <code>memory</code> or <code>hybrid</code>.
  EMQX will drop old cached messages under high memory pressure. The high memory threshold is defined in config <code>sysmon.os.sysmem_high_watermark</code>.


## bridge_kafka:producer_kafka_opts <a id='bridge_kafka-producer_kafka_opts'></a>
Kafka producer configs.


**Config paths**

 - <code>bridges.kafka.$name.producer.kafka</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__PRODUCER__KAFKA</code>


**Fields**

- topic: <code>string()</code>
  Kafka topic name

- message: <code>[bridge_kafka:kafka_message](#bridge_kafka-kafka_message)</code>
  Template to render a Kafka message.

- max_batch_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"896KB"`

  Maximum bytes to collect in a Kafka message batch. Most of the Kafka brokers default to a limit of 1 MB batch size. EMQX's default value is less than 1 MB in order to compensate Kafka message encoding overheads (especially when each individual message is very small). When a single message is over the limit, it is still sent (as a single element batch).

- compression: <code>no_compression | snappy | gzip</code>
  * default: 
  `no_compression`

  Compression method.

- partition_strategy: <code>random | key_dispatch</code>
  * default: 
  `random`

  Partition strategy is to tell the producer how to dispatch messages to Kafka partitions.
  <code>random</code>: Randomly pick a partition for each message
  <code>key_dispatch</code>: Hash Kafka message key to a partition number

- required_acks: <code>all_isr | leader_only | none</code>
  * default: 
  `all_isr`

  Required acknowledgements for Kafka partition leader to wait for its followers before it sends back the acknowledgement to EMQX Kafka producer
  <code>all_isr</code>: Require all in-sync replicas to acknowledge.
  <code>leader_only</code>: Require only the partition-leader's acknowledgement.
  <code>none</code>: No need for Kafka to acknowledge at all.

- partition_count_refresh_interval: <code>emqx_schema:duration_s()</code>
  * default: 
  `"60s"`

  The time interval for Kafka producer to discover increased number of partitions.
  After the number of partitions is increased in Kafka, EMQX will start taking the 
  discovered partitions into account when dispatching messages per <code>partition_strategy</code>.

- max_inflight: <code>pos_integer()</code>
  * default: 
  `10`

  Maximum number of batches allowed for Kafka producer (per-partition) to send before receiving acknowledgement from Kafka. Greater value typically means better throughput. However, there can be a risk of message reordering when this value is greater than 1.

- buffer: <code>[bridge_kafka:producer_buffer](#bridge_kafka-producer_buffer)</code>
  Configure producer message buffer.
  Tell Kafka producer how to buffer messages when EMQX has more messages to send than Kafka can keep up, or when Kafka is down.


## bridge_kafka:producer_mqtt_opts <a id='bridge_kafka-producer_mqtt_opts'></a>
MQTT data source. Optional when used as a rule-engine action.


**Config paths**

 - <code>bridges.kafka.$name.producer.mqtt</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__PRODUCER__MQTT</code>


**Fields**

- topic: <code>binary()</code>
  MQTT topic or topic as data source (bridge input).


## bridge_kafka:producer_opts <a id='bridge_kafka-producer_opts'></a>
Local MQTT data source and Kafka bridge configs.


**Config paths**

 - <code>bridges.kafka.$name.producer</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__PRODUCER</code>


**Fields**

- mqtt: <code>[bridge_kafka:producer_mqtt_opts](#bridge_kafka-producer_mqtt_opts)</code>
  MQTT data source. Optional when used as a rule-engine action.

- kafka: <code>[bridge_kafka:producer_kafka_opts](#bridge_kafka-producer_kafka_opts)</code>
  Kafka producer configs.


## bridge_kafka:socket_opts <a id='bridge_kafka-socket_opts'></a>
Extra socket options.


**Config paths**

 - <code>bridges.kafka.$name.socket_opts</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME__SOCKET_OPTS</code>


**Fields**

- sndbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1024KB"`

  Fine tune the socket send buffer. The default value is tuned for high throughput.

- recbuf: <code>emqx_schema:bytesize()</code>
  * default: 
  `"1024KB"`

  Fine tune the socket receive buffer. The default value is tuned for high throughput.

- nodelay: <code>boolean()</code>
  * default: 
  `true`

  When set to 'true', TCP buffer sent as soon as possible. Otherwise, the OS kernel may buffer small TCP packets for a while (40 ms by default).


## bridge_kafka:config <a id='bridge_kafka-config'></a>
Configuration for a Kafka bridge.


**Config paths**

 - <code>bridges.kafka.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__KAFKA__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable (true) or disable (false) this Kafka bridge.

- bootstrap_hosts: <code>binary()</code>
  A comma separated list of Kafka <code>host:port</code> endpoints to bootstrap the client.

- connect_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"5s"`

  Maximum wait time for TCP connection establishment (including authentication time if enabled).

- min_metadata_refresh_interval: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"3s"`

  Minimum time interval the client has to wait before refreshing Kafka broker and topic metadata. Setting too small value may add extra load on Kafka.

- metadata_request_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"5s"`

  Maximum wait time when fetching metadata from Kafka.

- authentication: <code>none | [bridge_kafka:auth_username_password](#bridge_kafka-auth_username_password) | [bridge_kafka:auth_gssapi_kerberos](#bridge_kafka-auth_gssapi_kerberos)</code>
  * default: 
  `none`

  Authentication configs.

- producer: <code>none | [bridge_kafka:producer_opts](#bridge_kafka-producer_opts)</code>
  Local MQTT data source and Kafka bridge configs.

- socket_opts: <code>[bridge_kafka:socket_opts](#bridge_kafka-socket_opts)</code>
  Extra socket options.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_mongodb:mongodb_rs <a id='bridge_mongodb-mongodb_rs'></a>
MongoDB (Replica Set) configuration


**Config paths**

 - <code>bridges.mongodb_rs.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MONGODB_RS__$NAME</code>


**Fields**

- mongo_type: <code>rs</code>
  * default: 
  `rs`

  Replica set.

- servers: <code>[term()]</code>
  A Node list for Cluster to connect to. The nodes should be separated with commas, such as: `Node[,Node].`
  For each Node should be: The IPv4 or IPv6 address or the hostname to connect to.
  A host entry has the following form: `Host[:Port]`.
  The MongoDB default port 27017 is used if `[:Port]` is not specified.

- w_mode: <code>unsafe | safe</code>
  * default: 
  `unsafe`

  Write mode.

- r_mode: <code>master | slave_ok</code>
  * default: 
  `master`

  Read mode.

- replica_set_name: <code>binary()</code>
  Name of the replica set.

- srv_record: <code>boolean()</code>
  * default: 
  `false`

  Use DNS SRV record.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- username: <code>binary()</code>
  EMQX's username in the external database.

- password: <code>binary()</code>
  EMQX's password in the external database.

- auth_source: <code>binary()</code>
  Database name associated with the user's credentials.

- database: <code>binary()</code>
  Database name.

- topology: <code>[topology](#topology)</code>


- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this MongoDB Bridge

- collection: <code>binary()</code>
  * default: 
  `"mqtt"`

  The collection where data will be stored into


## bridge_mongodb:mongodb_sharded <a id='bridge_mongodb-mongodb_sharded'></a>
MongoDB (Sharded) configuration


**Config paths**

 - <code>bridges.mongodb_sharded.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MONGODB_SHARDED__$NAME</code>


**Fields**

- mongo_type: <code>sharded</code>
  * default: 
  `sharded`

  Sharded cluster.

- servers: <code>[term()]</code>
  A Node list for Cluster to connect to. The nodes should be separated with commas, such as: `Node[,Node].`
  For each Node should be: The IPv4 or IPv6 address or the hostname to connect to.
  A host entry has the following form: `Host[:Port]`.
  The MongoDB default port 27017 is used if `[:Port]` is not specified.

- w_mode: <code>unsafe | safe</code>
  * default: 
  `unsafe`

  Write mode.

- srv_record: <code>boolean()</code>
  * default: 
  `false`

  Use DNS SRV record.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- username: <code>binary()</code>
  EMQX's username in the external database.

- password: <code>binary()</code>
  EMQX's password in the external database.

- auth_source: <code>binary()</code>
  Database name associated with the user's credentials.

- database: <code>binary()</code>
  Database name.

- topology: <code>[topology](#topology)</code>


- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this MongoDB Bridge

- collection: <code>binary()</code>
  * default: 
  `"mqtt"`

  The collection where data will be stored into


## bridge_mongodb:mongodb_single <a id='bridge_mongodb-mongodb_single'></a>
MongoDB (Standalone) configuration


**Config paths**

 - <code>bridges.mongodb_single.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MONGODB_SINGLE__$NAME</code>


**Fields**

- mongo_type: <code>single</code>
  * default: 
  `single`

  Standalone instance.

- server: <code>emqx_schema:host_port()</code>
  The IPv4 or IPv6 address or the hostname to connect to.<br/>
  A host entry has the following form: `Host[:Port]`.<br/>
  The MongoDB default port 27017 is used if `[:Port]` is not specified.

- w_mode: <code>unsafe | safe</code>
  * default: 
  `unsafe`

  Write mode.

- srv_record: <code>boolean()</code>
  * default: 
  `false`

  Use DNS SRV record.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- username: <code>binary()</code>
  EMQX's username in the external database.

- password: <code>binary()</code>
  EMQX's password in the external database.

- auth_source: <code>binary()</code>
  Database name associated with the user's credentials.

- database: <code>binary()</code>
  Database name.

- topology: <code>[topology](#topology)</code>


- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this MongoDB Bridge

- collection: <code>binary()</code>
  * default: 
  `"mqtt"`

  The collection where data will be stored into


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

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
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


## bridge_mysql:config <a id='bridge_mysql-config'></a>
Configuration for an HStreamDB bridge.


**Config paths**

 - <code>bridges.mysql.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MYSQL__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- sql: <code>binary()</code>
  * default: 
  `"insert into t_mqtt_msg(msgid, topic, qos, payload, arrived) values (${id}, ${topic}, ${qos}, ${payload}, FROM_UNIXTIME(${timestamp}/1000))"`

  SQL Template

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to MySQL. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- resource_opts: <code>[bridge_mysql:creation_opts](#bridge_mysql-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- server: <code>emqx_schema:host_port()</code>
  The IPv4 or IPv6 address or the hostname to connect to.<br/>
  A host entry has the following form: `Host[:Port]`.<br/>
  The MySQL default port 3306 is used if `[:Port]` is not specified.

- database: <code>binary()</code>
  Database name.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- username: <code>binary()</code>
  EMQX's username in the external database.

- password: <code>binary()</code>
  EMQX's password in the external database.

- auto_reconnect: <code>boolean()</code>
  * default: 
  `true`

  Enable automatic reconnect to the database.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_mysql:creation_opts <a id='bridge_mysql-creation_opts'></a>
Creation options.


**Config paths**

 - <code>bridges.mysql.$name.resource_opts</code>

**Env overrides**

 - <code>EMQX_BRIDGES__MYSQL__$NAME__RESOURCE_OPTS</code>


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

- enable_batch: <code>boolean()</code>
  * default: 
  `true`

  Batch mode enabled.

- batch_size: <code>pos_integer()</code>
  * default: 
  `100`

  Maximum batch count.

- batch_time: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"20ms"`

  Maximum batch waiting interval.

- enable_queue: <code>boolean()</code>
  * default: 
  `false`

  Queue mode enabled.

- max_queue_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  Maximum queue storage.


## bridge_redis:redis_cluster <a id='bridge_redis-redis_cluster'></a>
Cluster mode


**Config paths**

 - <code>bridges.redis_cluster.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__REDIS_CLUSTER__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to Redis. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- command_template: <code>[binary()]</code>
  Redis Command Template

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- servers: <code>[term()]</code>
  A Node list for Cluster to connect to. The nodes should be separated with commas, such as: `Node[,Node].`
  For each Node should be: The IPv4 or IPv6 address or the hostname to connect to.
  A host entry has the following form: `Host[:Port]`.
  The MongoDB default port 27017 is used if `[:Port]` is not specified.

- redis_type: <code>cluster</code>
  * default: 
  `cluster`

  Cluster mode

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- password: <code>binary()</code>
  EMQX's password in the external database.

- auto_reconnect: <code>boolean()</code>
  * default: 
  `true`

  Enable automatic reconnect to the database.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_redis:redis_sentinel <a id='bridge_redis-redis_sentinel'></a>
Sentinel mode


**Config paths**

 - <code>bridges.redis_sentinel.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__REDIS_SENTINEL__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to Redis. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- command_template: <code>[binary()]</code>
  Redis Command Template

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- servers: <code>[term()]</code>
  A Node list for Cluster to connect to. The nodes should be separated with commas, such as: `Node[,Node].`
  For each Node should be: The IPv4 or IPv6 address or the hostname to connect to.
  A host entry has the following form: `Host[:Port]`.
  The MongoDB default port 27017 is used if `[:Port]` is not specified.

- redis_type: <code>sentinel</code>
  * default: 
  `sentinel`

  Sentinel mode

- sentinel: <code>string()</code>
  The cluster name in Redis sentinel mode.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- password: <code>binary()</code>
  EMQX's password in the external database.

- database: <code>integer()</code>
  * default: 
  `0`

  Redis database ID.

- auto_reconnect: <code>boolean()</code>
  * default: 
  `true`

  Enable automatic reconnect to the database.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## bridge_redis:redis_single <a id='bridge_redis-redis_single'></a>
Single mode


**Config paths**

 - <code>bridges.redis_single.$name</code>

**Env overrides**

 - <code>EMQX_BRIDGES__REDIS_SINGLE__$NAME</code>


**Fields**

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable this bridge

- local_topic: <code>binary()</code>
  The MQTT topic filter to be forwarded to Redis. All MQTT 'PUBLISH' messages with the topic
  matching the local_topic will be forwarded.</br>
  NOTE: if this bridge is used as the action of a rule (EMQX rule engine), and also local_topic is
  configured, then both the data got from the rule and the MQTT messages that match local_topic
  will be forwarded.

- command_template: <code>[binary()]</code>
  Redis Command Template

- resource_opts: <code>[resource_schema:creation_opts](#resource_schema-creation_opts)</code>
  * default: 
  `{}`

  Resource options.

- server: <code>emqx_schema:host_port()</code>
  The IPv4 or IPv6 address or the hostname to connect to.<br/>
  A host entry has the following form: `Host[:Port]`.<br/>
  The Redis default port 6379 is used if `[:Port]` is not specified.

- redis_type: <code>single</code>
  * default: 
  `single`

  Single mode

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  Size of the connection pool.

- password: <code>binary()</code>
  EMQX's password in the external database.

- database: <code>integer()</code>
  * default: 
  `0`

  Redis database ID.

- auto_reconnect: <code>boolean()</code>
  * default: 
  `true`

  Enable automatic reconnect to the database.

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


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

- ssl: <code>[broker:ssl_client_opts](emqx.md#broker-ssl_client_opts)</code>
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


## resource_schema:creation_opts <a id='resource_schema-creation_opts'></a>
Creation options.


**Config paths**

 - <code>bridges.gcp_pubsub.$name.resource_opts</code>
 - <code>bridges.influxdb_api_v1.$name.resource_opts</code>
 - <code>bridges.influxdb_api_v2.$name.resource_opts</code>
 - <code>bridges.redis_cluster.$name.resource_opts</code>
 - <code>bridges.redis_sentinel.$name.resource_opts</code>
 - <code>bridges.redis_single.$name.resource_opts</code>

**Env overrides**

 - <code>EMQX_BRIDGES__GCP_PUBSUB__$NAME__RESOURCE_OPTS</code>
 - <code>EMQX_BRIDGES__INFLUXDB_API_V1__$NAME__RESOURCE_OPTS</code>
 - <code>EMQX_BRIDGES__INFLUXDB_API_V2__$NAME__RESOURCE_OPTS</code>
 - <code>EMQX_BRIDGES__REDIS_CLUSTER__$NAME__RESOURCE_OPTS</code>
 - <code>EMQX_BRIDGES__REDIS_SENTINEL__$NAME__RESOURCE_OPTS</code>
 - <code>EMQX_BRIDGES__REDIS_SINGLE__$NAME__RESOURCE_OPTS</code>


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

- enable_batch: <code>boolean()</code>
  * default: 
  `true`

  Batch mode enabled.

- batch_size: <code>pos_integer()</code>
  * default: 
  `100`

  Maximum batch count.

- batch_time: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"20ms"`

  Maximum batch waiting interval.

- enable_queue: <code>boolean()</code>
  * default: 
  `false`

  Queue mode enabled.

- max_queue_bytes: <code>emqx_schema:bytesize()</code>
  * default: 
  `"100MB"`

  Maximum queue storage.


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


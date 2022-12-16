# Authorization

## authz:file <a id='authz-file'></a>
Authorization using a static file.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>file</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- path: <code>string()</code>
  Path to the file which contains the ACL rules.
  If the file provisioned before starting EMQX node,
  it can be placed anywhere as long as EMQX has read access to it.
  That is, EMQX will treat it as read only.
  In case the rule-set is created or updated from EMQX Dashboard or HTTP API,
  a new file will be created and placed in `authz` subdirectory inside EMQX's `data_dir`,
  and the old file will not be used anymore.


## authz:http_get <a id='authz-http_get'></a>
Authorization using an external HTTP server (via GET requests).


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>http</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- url: <code>binary()</code>
  URL of the auth server.

- request_timeout: <code>string()</code>
  * default: 
  `"30s"`

  HTTP request timeout.

- body: <code>map()</code>
  HTTP request body.

- connect_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  The timeout when connecting to the HTTP server.

- enable_pipelining: <code>pos_integer()</code>
  * default: 
  `100`

  A positive integer. Whether to send HTTP requests continuously, when set to 1, it means that after each HTTP request is sent, you need to wait for the server to return and then continue to send the next request.

- max_retries: <code>non_neg_integer()</code>
  Deprecated since 5.0.4.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  The pool size.

- request: <code>[connector-http:request](others.md#connector-http-request)</code>
  If the request is provided, the caller can send HTTP requests via
  <code>emqx_resource:query(ResourceId, {send_message, BridgeId, Message})</code>

- retry_interval: <code>emqx_schema:duration()</code>
  Deprecated since 5.0.4.

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- method: <code>get</code>
  * default: 
  `get`

  HTTP method.

- headers: <code>[{binary(), binary()}]</code>
  * default: 
  ```
  {
    accept = "application/json"
    "cache-control" = "no-cache"
    connection = "keep-alive"
    "keep-alive" = "timeout=30, max=1000"
  }
  ```

  List of HTTP headers (without <code>content-type</code>).


## authz:http_post <a id='authz-http_post'></a>
Authorization using an external HTTP server (via POST requests).


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>http</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- url: <code>binary()</code>
  URL of the auth server.

- request_timeout: <code>string()</code>
  * default: 
  `"30s"`

  HTTP request timeout.

- body: <code>map()</code>
  HTTP request body.

- connect_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"15s"`

  The timeout when connecting to the HTTP server.

- enable_pipelining: <code>pos_integer()</code>
  * default: 
  `100`

  A positive integer. Whether to send HTTP requests continuously, when set to 1, it means that after each HTTP request is sent, you need to wait for the server to return and then continue to send the next request.

- max_retries: <code>non_neg_integer()</code>
  Deprecated since 5.0.4.

- pool_size: <code>pos_integer()</code>
  * default: 
  `8`

  The pool size.

- request: <code>[connector-http:request](others.md#connector-http-request)</code>
  If the request is provided, the caller can send HTTP requests via
  <code>emqx_resource:query(ResourceId, {send_message, BridgeId, Message})</code>

- retry_interval: <code>emqx_schema:duration()</code>
  Deprecated since 5.0.4.

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- method: <code>post</code>
  * default: 
  `post`

  HTTP method.

- headers: <code>[{binary(), binary()}]</code>
  * default: 
  ```
  {
    accept = "application/json"
    "cache-control" = "no-cache"
    connection = "keep-alive"
    "content-type" = "application/json"
    "keep-alive" = "timeout=30, max=1000"
  }
  ```

  List of HTTP Headers.


## authz:mnesia <a id='authz-mnesia'></a>
Authorization using a built-in database (mnesia).


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>built_in_database</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider


## authz:mongo_rs <a id='authz-mongo_rs'></a>
Authorization using a MongoDB replica set.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>mongodb</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- collection: <code>atom()</code>
  `MongoDB` collection containing the authorization data.

- filter: <code>map()</code>
  * default: 
  `{}`

  Conditional expression that defines the filter condition in the query.
  Filter supports the following placeholders:
   - <code>${username}</code>: Will be replaced at runtime with <code>Username</code> used by the client when connecting
   - <code>${clientid}</code>: Will be replaced at runtime with <code>Client ID</code> used by the client when connecting

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

- topology: <code>[topology](others.md#topology)</code>


- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## authz:mongo_sharded <a id='authz-mongo_sharded'></a>
Authorization using a sharded MongoDB cluster.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>mongodb</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- collection: <code>atom()</code>
  `MongoDB` collection containing the authorization data.

- filter: <code>map()</code>
  * default: 
  `{}`

  Conditional expression that defines the filter condition in the query.
  Filter supports the following placeholders:
   - <code>${username}</code>: Will be replaced at runtime with <code>Username</code> used by the client when connecting
   - <code>${clientid}</code>: Will be replaced at runtime with <code>Client ID</code> used by the client when connecting

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

- topology: <code>[topology](others.md#topology)</code>


- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## authz:mongo_single <a id='authz-mongo_single'></a>
Authorization using a single MongoDB instance.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>mongodb</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- collection: <code>atom()</code>
  `MongoDB` collection containing the authorization data.

- filter: <code>map()</code>
  * default: 
  `{}`

  Conditional expression that defines the filter condition in the query.
  Filter supports the following placeholders:
   - <code>${username}</code>: Will be replaced at runtime with <code>Username</code> used by the client when connecting
   - <code>${clientid}</code>: Will be replaced at runtime with <code>Client ID</code> used by the client when connecting

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

- topology: <code>[topology](others.md#topology)</code>


- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.


## authz:mysql <a id='authz-mysql'></a>
Authorization using a MySQL database.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>mysql</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

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

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- prepare_statement: <code>map()</code>
  Key-value list of SQL prepared statements.

- query: <code>binary()</code>
  Database query used to retrieve authorization data.


## authz:postgresql <a id='authz-postgresql'></a>
Authorization using a PostgreSQL database.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>postgresql</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

- server: <code>emqx_schema:host_port()</code>
  The IPv4 or IPv6 address or the hostname to connect to.<br/>
  A host entry has the following form: `Host[:Port]`.<br/>
  The PostgreSQL default port 5432 is used if `[:Port]` is not specified.

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

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- prepare_statement: <code>map()</code>
  Key-value list of SQL prepared statements.

- query: <code>binary()</code>
  Database query used to retrieve authorization data.


## authz:redis_cluster <a id='authz-redis_cluster'></a>
Authorization using a Redis cluster.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>redis</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

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

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- cmd: <code>binary()</code>
  Database query used to retrieve authorization data.


## authz:redis_sentinel <a id='authz-redis_sentinel'></a>
Authorization using a Redis Sentinel.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>redis</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

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

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- cmd: <code>binary()</code>
  Database query used to retrieve authorization data.


## authz:redis_single <a id='authz-redis_single'></a>
Authorization using a single Redis instance.


**Config paths**

 - <code>authorization.sources.$INDEX</code>

**Env overrides**

 - <code>EMQX_AUTHORIZATION__SOURCES__$INDEX</code>


**Fields**

- type: <code>redis</code>
  Backend type.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Set to <code>true</code> or <code>false</code> to disable this ACL provider

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

- ssl: <code>[broker:ssl_client_opts](others.md#broker-ssl_client_opts)</code>
  * default: 
  `{enable = false}`

  SSL connection settings.

- cmd: <code>binary()</code>
  Database query used to retrieve authorization data.


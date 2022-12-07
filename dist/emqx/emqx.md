# EMQX
EMQX configuration files are in [HOCON](https://github.com/emqx/hocon) format.
HOCON, or Human-Optimized Config Object Notation is a format for human-readable data,
and a superset of JSON.

## Layered

EMQX configuration consists of 3 layers.
From bottom up:

1. Immutable base: `emqx.conf` + `EMQX_` prefixed environment variables.<br/>
   Changes in this layer require a full node restart to take effect.
1. Cluster overrides: `$EMQX_NODE__DATA_DIR/configs/cluster-override.conf`
1. Local node overrides: `$EMQX_NODE__DATA_DIR/configs/local-override.conf`

When environment variable `$EMQX_NODE__DATA_DIR` is not set, config `node.data_dir`
is used.

The `cluster-override.conf` file is overwritten at runtime when changes
are made from dashboard UI, management HTTP API, or CLI. When clustered,
after EMQX restarts, it copies the file from the node which has the greatest `uptime`.

:::tip Tip
Some of the configs (such as `node.name`) are boot-only configs and not overridable.
Config values from `*-override.conf` are **not** mapped to boot configs for
the config fields attributed with `mapping: path.to.boot.config.key`
:::

For detailed override rules, see [Config Overlay Rules](#config-overlay-rules).

## Syntax

In config file the values can be notated as JSON like objects, such as
```
node {
    name = "emqx@127.0.0.1"
    cookie = "mysecret"
}
```

Another equivalent representation is flat, such as

```
node.name = "127.0.0.1"
node.cookie = "mysecret"
```

This flat format is almost backward compatible with EMQX's config file format
in 4.x series (the so called 'cuttlefish' format).

It is not fully compatible because the often HOCON requires strings to be quoted,
while cuttlefish treats all characters to the right of the `=` mark as the value.

e.g. cuttlefish: `node.name = emqx@127.0.0.1`, HOCON: `node.name = "emqx@127.0.0.1"`.

Strings without special characters in them can be unquoted in HOCON too,
e.g. `foo`, `foo_bar` and `foo_bar_1`.

For more HOCON syntax, please refer to the [specification](https://github.com/lightbend/config/blob/main/HOCON.md)

## Schema

To make the HOCON objects type-safe, EMQX introduced a schema for it.
The schema defines data types, and data fields' names and metadata for config value validation
and more.

::: tip Tip
The configuration document you are reading now is generated from schema metadata.
:::

### Complex Data Types

There are 4 complex data types in EMQX's HOCON config:

1. Struct: Named using an unquoted string, followed by a predefined list of fields.
   Only lowercase letters and digits are allowed in struct and field names.
   Alos, only underscore can be used as word separator.
1. Map: Map is like Struct, however the fields are not predefined.
1. Union: `MemberType1 | MemberType2 | ...`
1. Array: `[ElementType]`

::: tip Tip
If map filed name is a positive integer number, it is interpreted as an alternative representation of an `Array`.
For example:
```
myarray.1 = 74
myarray.2 = 75
```
will be interpreated as `myarray = [74, 75]`, which is handy when trying to override array elements.
:::

### Primitive Data Types

Complex types define data 'boxes' which may contain other complex data
or primitive values.
There are quite some different primitive types, to name a few:

* `atom()`.
* `boolean()`.
* `string()`.
* `integer()`.
* `float()`.
* `number()`.
* `binary()`, another format of string().
* `emqx_schema:duration()`, time duration, another format of integer()
* ...

::: tip Tip
The primitive types are mostly self-describing, so there is usually not a lot to document.
For types that are not so clear by their names, the field description is to be used to find the details.
:::

### Config Paths

If we consider the whole EMQX config as a tree,
to reference a primitive value, we can use a dot-separated names form string for
the path from the tree-root (always a Struct) down to the primitive values at tree-leaves.

Each segment of the dotted string is a Struct filed name or Map key.
For Array elements, 1-based index is used.

below are some examples

```
node.name = "emqx.127.0.0.1"
zone.zone1.max_packet_size = "10M"
authentication.1.enable = true
```

### Environment variables

Environment variables can be used to define or override config values.

Due to the fact that dots (`.`) are not allowed in environment variables, dots are
replaced with double-underscores (`__`).

And the `EMQX_` prefix is used as the namespace.

For example `node.name` can be represented as `EMQX_NODE__NAME`

Environment variable values are parsed as HOCON values, this allows users
to even set complex values from environment variables.

For example, this environment variable sets an array value.

```
export EMQX_LISTENERS__SSL__L1__AUTHENTICATION__SSL__CIPHERS='["TLS_AES_256_GCM_SHA384"]'
```

However this also means a string value should be quoted if it happens to contain special
characters such as `=` and `:`.

For example, a string value `"localhost:1883"` would be
parsed into object (struct): `{"localhost": 1883}`.

To keep it as a string, one should quote the value like below:

```
EMQX_BRIDGES__MQTT__MYBRIDGE__CONNECTOR_SERVER='"localhost:1883"'
```

::: tip Tip
Unknown root paths are silently discarded by EMQX, for example `EMQX_UNKNOWN_ROOT__FOOBAR` is
silently discarded because `unknown_root` is not a predefined root path.

Unknown field names in environment variables are logged as a `warning` level log, for example:

```
[warning] unknown_env_vars: ["EMQX_AUTHENTICATION__ENABLED"]
```

because the field name is `enable`, not `enabled`.
:::


### Config Overlay Rules

HOCON objects are overlaid, in general:

- Within one file, objects defined 'later' recursively override objects defined 'earlier'
- When layered, 'later' (higher layer) objects override objects defined 'earlier' (lower layer)

Below are more detailed rules.

#### Struct Fields

Later config values overwrites earlier values.
For example, in below config, the last line `debug` overwrites `error` for
console log handler's `level` config, but leaving `enable` unchanged.
```
log {
    console_handler{
        enable=true,
        level=error
    }
}

## ... more configs ...

log.console_handler.level=debug
```

#### Map Values

Maps are like structs, only the files are user-defined rather than
the config schema. For instance, `zone1` in the example below.

```
zone {
    zone1 {
        mqtt.max_packet_size = 1M
    }
}

## The maximum packet size can be defined as above,
## then overridden as below

zone.zone1.mqtt.max_packet_size = 10M
```

#### Array Elements

Arrays in EMQX config have two different representations

* list, such as: `[1, 2, 3]`
* indexed-map, such as: `{"1"=1, "2"=2, "3"=3}`

Dot-separated paths with number in it are parsed to indexed-maps
e.g. `authentication.1={...}` is parsed as `authentication={"1": {...}}`

This feature makes it easy to override array elment values. For example:

```
authentication=[{enable=true, backend="built_in_database", mechanism="password_based"}]
# we can disable this authentication provider with:
authentication.1.enable=false
```

::: warning Warning
List arrays is a full-array override, but not a recursive merge, into indexed-map arrays.
e.g.

```
authentication=[{enable=true, backend="built_in_database", mechanism="password_based"}]
## below value will replace the whole array, but not to override just one field.
authentication=[{enable=true}]
```
:::

#### TLS/SSL ciphers

Starting from v5.0.6, EMQX no longer pre-populates the ciphers list with a default
set of cipher suite names.
Instead, the default ciphers are applied at runtime when starting the listener
for servers, or when establishing a TLS connection as a client.

Below are the default ciphers selected by EMQX.

For tlsv1.3:
```
ciphers =
  [ "TLS_AES_256_GCM_SHA384", "TLS_AES_128_GCM_SHA256",
    "TLS_CHACHA20_POLY1305_SHA256", "TLS_AES_128_CCM_SHA256",
    "TLS_AES_128_CCM_8_SHA256"
  ]
```

For tlsv1.2 or earlier

```
ciphers =
  [ "ECDHE-ECDSA-AES256-GCM-SHA384",
    "ECDHE-RSA-AES256-GCM-SHA384",
    "ECDHE-ECDSA-AES256-SHA384",
    "ECDHE-RSA-AES256-SHA384",
    "ECDH-ECDSA-AES256-GCM-SHA384",
    "ECDH-RSA-AES256-GCM-SHA384",
    "ECDH-ECDSA-AES256-SHA384",
    "ECDH-RSA-AES256-SHA384",
    "DHE-DSS-AES256-GCM-SHA384",
    "DHE-DSS-AES256-SHA256",
    "AES256-GCM-SHA384",
    "AES256-SHA256",
    "ECDHE-ECDSA-AES128-GCM-SHA256",
    "ECDHE-RSA-AES128-GCM-SHA256",
    "ECDHE-ECDSA-AES128-SHA256",
    "ECDHE-RSA-AES128-SHA256",
    "ECDH-ECDSA-AES128-GCM-SHA256",
    "ECDH-RSA-AES128-GCM-SHA256",
    "ECDH-ECDSA-AES128-SHA256",
    "ECDH-RSA-AES128-SHA256",
    "DHE-DSS-AES128-GCM-SHA256",
    "DHE-DSS-AES128-SHA256",
    "AES128-GCM-SHA256",
    "AES128-SHA256",
    "ECDHE-ECDSA-AES256-SHA",
    "ECDHE-RSA-AES256-SHA",
    "DHE-DSS-AES256-SHA",
    "ECDH-ECDSA-AES256-SHA",
    "ECDH-RSA-AES256-SHA",
    "ECDHE-ECDSA-AES128-SHA",
    "ECDHE-RSA-AES128-SHA",
    "DHE-DSS-AES128-SHA",
    "ECDH-ECDSA-AES128-SHA",
    "ECDH-RSA-AES128-SHA"
  ]
```

For PSK enabled listeners

```
ciphers =
  [ "RSA-PSK-AES256-GCM-SHA384",
    "RSA-PSK-AES256-CBC-SHA384",
    "RSA-PSK-AES128-GCM-SHA256",
    "RSA-PSK-AES128-CBC-SHA256",
    "RSA-PSK-AES256-CBC-SHA",
    "RSA-PSK-AES128-CBC-SHA"
  ]
```

## cluster_dns
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


## cluster_etcd
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


## cluster_k8s
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


## cluster_mcast
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


## cluster_static
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


## authorization
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



- sources: <code>[[authz:file](#authz-file) | [authz:http_get](#authz-http_get) | [authz:http_post](#authz-http_post) | [authz:mnesia](#authz-mnesia) | [authz:mongo_single](#authz-mongo_single) | [authz:mongo_rs](#authz-mongo_rs) | [authz:mongo_sharded](#authz-mongo_sharded) | [authz:mysql](#authz-mysql) | [authz:postgresql](#authz-postgresql) | [authz:redis_single](#authz-redis_single) | [authz:redis_sentinel](#authz-redis_sentinel) | [authz:redis_cluster](#authz-redis_cluster)]</code>
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



## cluster
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




## cluster_call
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


## console_handler
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


## log
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


## log_burst_limit
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


## log_file_handler
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


## log_overload_kill

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


## log_rotation

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


## node
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



## rpc
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



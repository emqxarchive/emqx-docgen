# Rule Engine

## rule_engine:builtin_action_console <a id='rule_engine-builtin_action_console'></a>
Configuration for a built-in action.

| Config paths | Env overrides |
|---------------------------------------------------|------------------------------------------------------------|
|  <code>rule_engine.rules.$id.actions.$INDEX</code> | <code>EMQX_RULE_ENGINE__RULES__$ID__ACTIONS__$INDEX</code>  |


**Fields**

- function: <code>console</code>
  Print the actions to the console


## rule_engine:builtin_action_republish <a id='rule_engine-builtin_action_republish'></a>
Configuration for a built-in action.

| Config paths | Env overrides |
|---------------------------------------------------|------------------------------------------------------------|
|  <code>rule_engine.rules.$id.actions.$INDEX</code> | <code>EMQX_RULE_ENGINE__RULES__$ID__ACTIONS__$INDEX</code>  |


**Fields**

- function: <code>republish</code>
  Republish the message as a new MQTT message

- args: <code>[rule_engine:republish_args](#rule_engine-republish_args)</code>
  * default: 
  `{}`




## rule_engine:republish_args <a id='rule_engine-republish_args'></a>
The arguments of the built-in 'republish' action.One can use variables in the args.
The variables are selected by the rule. For example, if the rule SQL is defined as following:
<code>
    SELECT clientid, qos, payload FROM "t/1"
</code>
Then there are 3 variables available: <code>clientid</code>, <code>qos</code> and
<code>payload</code>. And if we've set the args to:
<code>
    {
        topic = "t/${clientid}"
        qos = "${qos}"
        payload = "msg: ${payload}"
    }
</code>
When the rule is triggered by an MQTT message with payload = `hello`, qos = 1,
clientid = `Steve`, the rule will republish a new MQTT message to topic `t/Steve`,
payload = `msg: hello`, and `qos = 1`.

| Config paths | Env overrides |
|--------------------------------------------------------|------------------------------------------------------------------|
|  <code>rule_engine.rules.$id.actions.$INDEX.args</code> | <code>EMQX_RULE_ENGINE__RULES__$ID__ACTIONS__$INDEX__ARGS</code>  |


**Fields**

- topic: <code>binary()</code>
  The target topic of message to be re-published.
  Template with variables is allowed, see description of the 'republish_args'.

- qos: <code>qos() | binary()</code>
  * default: 
  `"${qos}"`

  The qos of the message to be re-published.
  Template with variables is allowed, see description of the 'republish_args'.
  Defaults to ${qos}. If variable ${qos} is not found from the selected result of the rule,
  0 is used.

- retain: <code>boolean() | binary()</code>
  * default: 
  `"${retain}"`

  The 'retain' flag of the message to be re-published.
  Template with variables is allowed, see description of the 'republish_args'.
  Defaults to ${retain}. If variable ${retain} is not found from the selected result
  of the rule, false is used.

- payload: <code>binary()</code>
  * default: 
  `"${payload}"`

  The payload of the message to be re-published.
  Template with variables is allowed, see description of the 'republish_args'.
  Defaults to ${payload}. If variable ${payload} is not found from the selected result
  of the rule, then the string "undefined" is used.

- user_properties: <code>binary()</code>
  * default: 
  `"${user_properties}"`

  From which variable should the MQTT message's User-Property pairs be taken from.
  The value must be a map.
  You may configure it to <code>${pub_props.'User-Property'}</code> or
  use <code>SELECT *,pub_props.'User-Property' as user_properties</code>
  to forward the original user properties to the republished message.
  You may also call <code>map_put</code> function like
  <code>map_put('my-prop-name', 'my-prop-value', user_properties) as user_properties</code>
  to inject user properties.
  NOTE: MQTT spec allows duplicated user property names, but EMQX Rule-Engine does not.


## rule_engine <a id='rule_engine'></a>
Configuration for the EMQX Rule Engine.

| Config paths | Env overrides |
|--------------------------|-------------------------------|
|  <code>rule_engine</code> | <code>EMQX_RULE_ENGINE</code>  |


**Fields**

- ignore_sys_message: <code>boolean()</code>
  * default: 
  `true`

  When set to 'true' (default), rule-engine will ignore messages published to $SYS topics.

- rules: <code>{$id -> [rule_engine:rules](#rule_engine-rules)}</code>
  * default: 
  `{}`

  The rules

- jq_function_default_timeout: <code>emqx_schema:duration_ms()</code>
  * default: 
  `"10s"`

  Default timeout for the `jq` rule engine function

- jq_implementation_module: <code>jq_nif | jq_port</code>
  * default: 
  `jq_nif`

  * mapping: 
  `jq.jq_implementation_module`

  The implementation module for the jq rule engine function. The two options are jq_nif and jq_port. With the jq_nif option an Erlang NIF library is used while with the jq_port option an implementation based on Erlang port programs is used. The jq_nif option (the default option) is the fastest implementation of the two but jq_port is safer as the jq programs will not execute in the same process as the Erlang VM.


## rule_engine:rules <a id='rule_engine-rules'></a>
Configuration for a rule.

| Config paths | Env overrides |
|------------------------------------|-------------------------------------------|
|  <code>rule_engine.rules.$id</code> | <code>EMQX_RULE_ENGINE__RULES__$ID</code>  |


**Fields**

- name: <code>binary()</code>
  * default: 
  `""`

  The name of the rule

- sql: <code>binary()</code>
  SQL query to transform the messages.
  Example: <code>SELECT * FROM "test/topic" WHERE payload.x = 1</code>

- actions: <code>[binary() | [rule_engine:builtin_action_republish](#rule_engine-builtin_action_republish) | [rule_engine:builtin_action_console](#rule_engine-builtin_action_console) | [rule_engine:user_provided_function](#rule_engine-user_provided_function)]</code>
  * default: 
  `[]`

  A list of actions of the rule.
  An action can be a string that refers to the channel ID of an EMQX bridge, or an object
  that refers to a function.
  There a some built-in functions like "republish" and "console", and we also support user
  provided functions in the format: "{module}:{function}".
  The actions in the list are executed sequentially.
  This means that if one of the action is executing slowly, all the following actions will not
  be executed until it returns.
  If one of the action crashed, all other actions come after it will still be executed, in the
  original order.
  If there's any error when running an action, there will be an error message, and the 'failure'
  counter of the function action or the bridge channel will increase.

- enable: <code>boolean()</code>
  * default: 
  `true`

  Enable or disable the rule

- description: <code>binary()</code>
  * default: 
  `""`

  The description of the rule

- metadata: <code>map()</code>
  Rule metadata, do not change manually


## rule_engine:user_provided_function <a id='rule_engine-user_provided_function'></a>
Configuration for a built-in action.

| Config paths | Env overrides |
|---------------------------------------------------|------------------------------------------------------------|
|  <code>rule_engine.rules.$id.actions.$INDEX</code> | <code>EMQX_RULE_ENGINE__RULES__$ID__ACTIONS__$INDEX</code>  |


**Fields**

- function: <code>binary()</code>
  The user provided function. Should be in the format: '{module}:{function}'.
  Where {module} is the Erlang callback module and {function} is the Erlang function.
  To write your own function, checkout the function <code>console</code> and
  <code>republish</code> in the source file:
  <code>apps/emqx_rule_engine/src/emqx_rule_actions.erl</code> as an example.

- args: <code>map()</code>
  * default: 
  `{}`

  The args will be passed as the 3rd argument to module:function/3,
  checkout the function <code>console</code> and <code>republish</code> in the source file:
  <code>apps/emqx_rule_engine/src/emqx_rule_actions.erl</code> as an example.


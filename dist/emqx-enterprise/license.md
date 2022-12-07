License

## key_license
License provisioned as a string.


**Tags**

 - <code>License</code>


**Config paths**

 - <code>license</code>


**Env overrides**

 - <code>EMQX_LICENSE</code>



**Fields**

- key: <code>binary()</code>
  * default: 
  `"MjIwMTExCjAKMTAKRXZhbHVhdGlvbgpjb250YWN0QGVtcXguaW8KZGVmYXVsdAoyMDIyMDQxOQoxODI1CjEwMDAK.MEQCICbgRVijCQov2hrvZXR1mk9Oa+tyV1F5oJ6iOZeSHjnQAiB9dUiVeaZekDOjztk+NCWjhk4PG8tWfw2uFZWruSzD6g=="`

  License string

- connection_low_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"75%"`

  Low watermark limit below which license connection quota usage alarms are deactivated

- connection_high_watermark: <code>emqx_schema:percent()</code>
  * default: 
  `"80%"`

  High watermark limit above which license connection quota usage alarms are activated



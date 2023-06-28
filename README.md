# SNOWFLAKE_DART

### A Snowflake ID generator for Dart

Simple Generator for Snowflake IDs in Dart.

[![Pub](https://img.shields.io/pub/v/snowflake_dart.svg)](https://pub.dev/packages/snowflake_dart)


```dart
  var node = await Snowflake.create(1);
  var id = await node.generate();
  print(id);

  var timeFromId = Snowflake.getTimeFromId(id);
  print(timeFromId);
  var nodeFromId = Snowflake.getNodeFromId(id);
  print(nodeFromId);
  var stepFromId = Snowflake.getStepFromId(id);
  print(stepFromId);
```

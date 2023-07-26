# SNOWFLAKE_DART

### A full-featured Snowflake ID generator for Dart

Can set nodeBits, sequenceBits, epoch, nodeId, and generate id from DateTime.

[![Pub](https://img.shields.io/pub/v/snowflake_dart.svg)](https://pub.dev/packages/snowflake_dart)

```dart
import 'package:snowflake_dart/snowflake_dart.dart';

void main() async {
  var node = Snowflake(nodeId: 0);
  print(node.generate());
  // You can create from DateTime
  var id = node.generate(time: DateTime.now());
  print(id);

  var timeFromId = node.getTimeFromId(id);
  print(timeFromId);
  var nodeFromId = node.getNodeFromId(id);
  print(nodeFromId);
  var stepFromId = node.getSequenceFromId(id);
  print(stepFromId);

  // If you want to use a custom epoch, you can set:
  var node2 = Snowflake(nodeId: 0, epoch: 1688019071792);
  print(node2.generate());

  //  Also, can set nodeBits, sequenceBits
  // But sum of nodeBits and sequenceBits must be 22
  var node3 = Snowflake(nodeId: 0, nodeBits: 16, sequenceBits: 6);
  print(node3.generate());
  var node4 = Snowflake(nodeId: 0, nodeBits: 14, sequenceBits: 8);
  print(node4.generate());
}
```

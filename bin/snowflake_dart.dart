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

//
// void main() {
//   var snowflake = Snowflake(nodeId: 0); // Replace with your values
//   bool hasErr = false;
//   for (var i = 0; i < 10000; i++) {
//     var id = snowflake.generate();
//     var timestamp = snowflake.getTimeFromId(id);
//     var nodeId = snowflake.getNodeFromId(id);
//     var sequence = snowflake.getSequenceFromId(id);
//
//     if (!((timestamp - snowflake.epoch) << snowflake.timestampShift | (nodeId << snowflake.nodeShift) | sequence == id)) {
//       print('Failed at iteration $i');
//       hasErr = true;
//       break;
//     }
//   }
//   print('Test completed');
// }

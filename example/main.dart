import 'package:snowflake_dart/snowflake_dart.dart';

void main() async {
  var node = await Snowflake.create(1);
  var id = await node.generate();
  print(id);

  // You can create from DateTime
  var id2 = await node.generate(time: DateTime(2023, 1, 1));
  print(id2);

  var timeFromId = Snowflake.getTimeFromId(id);
  print(timeFromId);
  var nodeFromId = Snowflake.getNodeFromId(id);
  print(nodeFromId);
  var stepFromId = Snowflake.getStepFromId(id);
  print(stepFromId);

  // If you want to use a custom epoch, you can set:
  Snowflake.epoch = 1688019071792;
  print(Snowflake.epoch);
}

import 'package:snowflake_dart/snowflake_dart.dart';

void main() async {
  var node = await Snowflake.create(1);
  var id = await node.generate();
  print(id);

  var timeFromId = Snowflake.getTimeFromId(id);
  print(timeFromId);
  var nodeFromId = Snowflake.getNodeFromId(id);
  print(nodeFromId);
  var stepFromId = Snowflake.getStepFromId(id);
  print(stepFromId);
}

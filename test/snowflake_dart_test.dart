import 'package:snowflake_dart/snowflake_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Snowflake', () {
    late Snowflake snowflake;

    setUp(() async {
      snowflake = Snowflake(nodeId: 0);
    });

    test('generate', () async {
      bool hasErr = false;
      for (var i = 0; i < 10000; i++) {
        var id = snowflake.generate();
        var timestamp = snowflake.getTimeFromId(id);
        var nodeId = snowflake.getNodeFromId(id);
        var sequence = snowflake.getSequenceFromId(id);

        if (!((timestamp - snowflake.epoch) << snowflake.timestampShift |
                (nodeId << snowflake.nodeShift) |
                sequence ==
            id)) {
          print('Failed at iteration $i');
          hasErr = true;
          break;
        }
      }
      expect(hasErr, equals(false));
    });
  });
}

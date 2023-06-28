import 'package:snowflake_dart/snowflake_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Snowflake', () {
    late Snowflake snowflake;

    setUp(() async {
      snowflake = await Snowflake.create(10);
    });

    test('generate', () async {
      int id = await snowflake.generate();
      expect(id, isNotNull);
      expect(id, isA<int>());
    });

    test('getTimeFromId', () async {
      int id = await snowflake.generate();
      var time = Snowflake.getTimeFromId(id);
      expect(time, isA<DateTime>());
    });

    test('getNodeFromId', () async {
      int id = await snowflake.generate();
      var node = Snowflake.getNodeFromId(id);
      expect(node, isA<int>());
      expect(node, equals(10));
    });

    test('getStepFromId', () async {
      int id = await snowflake.generate();
      var step = Snowflake.getStepFromId(id);
      expect(step, isA<int>());
    });
  });
}

class Snowflake {
  // GMT: 2010년 November 4일 Thursday AM 1:42:54.657
  static int epoch = 1288834974657;
  static int nodeBits = 10;
  static int stepBits = 12;
  static int nodeMax = -1 ^ (-1 << nodeBits);
  static int nodeMask = nodeMax << stepBits;
  static int stepMask = -1 ^ (-1 << stepBits);
  static int timeShift = nodeBits + stepBits;
  static int nodeShift = stepBits;

  final int node;
  int _time = 0;
  int _step = 0;

  Snowflake._(this.node);

  static Future<Snowflake> create(int node) async {
    if (nodeBits + stepBits > 22) {
      throw ArgumentError('You have a total 22 bits to share between Node/Step');
    }
    if (node < 0 || node > nodeMax) {
      throw ArgumentError('Node number must be between 0 and $nodeMax');
    }
    return Snowflake._(node);
  }

  Future<int> generate({DateTime? time}) async {
    var now = time != null
        ? time.millisecondsSinceEpoch - epoch
        : DateTime.now().millisecondsSinceEpoch - epoch;
    if (now == _time) {
      _step = (_step + 1) & stepMask;

      if (_step == 0) {
        while (now <= _time) {
          now = (DateTime.now().millisecondsSinceEpoch - epoch);
        }
      }
    } else {
      _step = 0;
    }

    _time = now;
    return ((_time << timeShift) | (node << nodeShift) | _step);
  }

  static DateTime getTimeFromId(int id) {
    // Extract time from the snowflake ID
    int timestamp = (id >> Snowflake.timeShift);

    // Convert it to milliseconds since epoch
    int millisecondsSinceEpoch = timestamp + Snowflake.epoch;

    // Convert to DateTime and return
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  static int getNodeFromId(int id) {
    return (id & Snowflake.nodeMask) >> Snowflake.nodeShift;
  }

  static int getStepFromId(int id) {
    return id & Snowflake.stepMask;
  }
}

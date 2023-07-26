class Snowflake {
  final int nodeId;
  final int epoch;
  final int nodeBits;
  final int sequenceBits;
  late final int nodeMax;
  late final int sequenceMax;
  late final int nodeShift;
  late final int timestampShift;

  int sequence = 0;
  int lastTimestamp = -1;

  Snowflake({
    required this.nodeId,
    this.epoch = 1288834974657, // 2010-11-04T01:42:54.657Z
    this.nodeBits = 10,
    this.sequenceBits = 12,
  }) {
    if (nodeBits + sequenceBits != 22) {
      throw Exception("Sum of nodeBits and stepBits must be 22");
    }

    nodeMax = -1 ^ (-1 << nodeBits);
    sequenceMax = -1 ^ (-1 << sequenceBits);
    nodeShift = sequenceBits;
    timestampShift = sequenceBits + nodeBits;

    if (nodeId > nodeMax) {
      throw Exception("Node ID can't be greater than $nodeMax");
    }
  }

  int get now {
    return DateTime.now().millisecondsSinceEpoch;
  }

  int generate({DateTime? time}) {
    int now = time != null ? time.millisecondsSinceEpoch : this.now;

    if (now < lastTimestamp) {
      throw Exception("Invalid system clock");
    }

    if (lastTimestamp == now) {
      sequence = (sequence + 1) & sequenceMax;

      if (sequence == 0) {
        while (now <= lastTimestamp) {
          now = this.now;
        }
      }
    } else {
      sequence = 0;
    }

    lastTimestamp = now;

    if (now < epoch) {
      throw Exception(
          "Time is moving backwards.  Refusing to generate id for ${epoch - now} milliseconds");
    }
    // print(sequence);

    return ((now - epoch) << timestampShift) | (nodeId << nodeShift) | sequence;
  }

  int getTimeFromId(int id) {
    return (id >> timestampShift) + epoch;
  }

  int getNodeFromId(int id) {
    return (id & ((-1 ^ (-1 << nodeShift)) << sequenceBits)) >> sequenceBits;
  }

  int getSequenceFromId(int id) {
    return id & (-1 ^ (-1 << sequenceBits));
  }
}

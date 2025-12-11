import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class Extensions {}

extension StringLog on String {
  void printStr() {
    if (kDebugMode) {
      print(this);
    }
  }

  void logStr({
    String? name,
    Object? error,
  }) {
    return log(
      this,
      name: name ?? "",
      error: error,
    );
  }
}

extension StringListExtensions on List<String?> {
  List<String> withoutNullsOrEmpty() {
    return where((e) => e != null && e.trim().isNotEmpty)
        .cast<String>()
        .toList();
  }
}

extension HourlyShuffle<T> on List<T> {
  List<T> shuffledByHour() {
    final now = DateTime.now();

    // Seed changes every hour
    final seed =
        now.year * 1000000 + now.month * 10000 + now.day * 100 + now.hour;

    final random = math.Random(seed);

    // Create copy to avoid modifying original list
    final listCopy = List<T>.from(this);

    // Shuffle using seeded Random
    listCopy.shuffle(random);

    return listCopy;
  }
}

extension IntervalShuffle<T> on List<T> {
  List<T> shuffledByInterval(int minutes) {
    final now = DateTime.now();

    // Divide minutes by interval → stable shuffle per interval
    final intervalIndex = now.minute ~/ minutes;

    final seed = now.year * 1000000 +
        now.month * 10000 +
        now.day * 100 +
        now.hour * 100 +
        intervalIndex;

    final random = math.Random(seed);

    final listCopy = List<T>.from(this);
    listCopy.shuffle(random);

    return listCopy;
  }
}

extension IntFormatting on int {
  /// Formats the int with commas as thousand separators: 130000 -> 130,000
  String toCommaSeparated() {
    final str = toString();
    final buffer = StringBuffer();
    int count = 0;

    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write(',');
        count = 0;
      }
    }

    return buffer.toString().split('').reversed.join();
  }
}

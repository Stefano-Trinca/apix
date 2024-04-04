extension IntExt on int {
  /// Returns an ordinal number of `String` type for any integer
  ///
  /// ```dart
  /// 101.ordinal(); // 101st
  ///
  /// 999218.ordinal(); // 999218th
  /// ```
  String ordinal() {
    final onesPlace = this % 10;
    final tensPlace = ((this / 10).floor()) % 10;
    if (tensPlace == 1) {
      return '${this}th';
    } else {
      switch (onesPlace) {
        case 1:
          return '${this}st';
        case 2:
          return '${this}nd';
        case 3:
          return '${this}rd';
        default:
          return '${this}th';
      }
    }
  }


  /// Returns roman number representation of [int] from 1 to 3999
  /// ``` dart
  /// print(12.roman); // XII
  /// print(455.roman); // CDLV
  /// print(1.roman); // I
  /// print(3999.roman); // MMMCMXCIX
  /// ```
  String get roman {
    if (this < 1 || this > 3999) {
      throw Exception('Number out of range (1 to 3999)');
    }

    const romanTable = {
      'M': 1000,
      'CM': 900,
      'D': 500,
      'CD': 400,
      'C': 100,
      'XC': 90,
      'L': 50,
      'XL': 40,
      'X': 10,
      'IX': 9,
      'V': 5,
      'IV': 4,
      'I': 1,
    };

    final result = StringBuffer();
    var n = this;
    for (final entry in romanTable.entries) {
      final numeral = entry.key;
      final value = entry.value;
      while (n >= value) {
        result.write(numeral);
        n -= value;
      }
    }
    return result.toString();
  }
}

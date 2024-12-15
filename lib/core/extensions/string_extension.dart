extension NullableStringExt on String? {
  String addColor(StrColor color) {
    String str;
    switch (color) {
      case StrColor.black: //   \x1B[30m
        str = '\x1B[30m';
        break;
      case StrColor.red: //     \x1B[31m
        str = '\x1B[31m';
        break;
      case StrColor.green: //   \x1B[32m
        str = '\x1B[32m';
        break;
      case StrColor.yellow: //  \x1B[33m
        str = '\x1B[33m';
        break;
      case StrColor.blue: //    \x1B[34m
        str = '\x1B[34m';
        break;
      case StrColor.magenta: // \x1B[35m
        str = '\x1B[35m';
        break;
      case StrColor.cyan: //    \x1B[36m
        str = '\x1B[36m';
        break;
      case StrColor.white: //   \x1B[37m
        str = '\x1B[37m';
        break;
      case StrColor.reset: //   \x1B[0m
        str = '\x1B[0m';
        break;
      case StrColor.darkRed:
        str = '\x1B[38;5;166m';
        break;
      default:
        str = '';
    }
    return '$str$this\x1B[m';
  }

  bool get isBlank => this == null || this!.trim().isEmpty;

  String valueIfNull(String value) => isBlank ? value : this!;

  String? cut(int maxLength) => isBlank
      ? this
      : this!.length < maxLength
          ? this!.substring(0, this!.length)
          : (this!.substring(0, maxLength) + '...');
}

enum StrColor {
  black, //   \x1B[30m
  red, //     \x1B[31m
  green, //   \x1B[32m
  yellow, //  \x1B[33m
  blue, //    \x1B[34m
  magenta, // \x1B[35m
  cyan, //    \x1B[36m
  white, //   \x1B[37m
  reset, //   \x1B[0m
  darkRed,
  emitSocket,
  onSocket,
}

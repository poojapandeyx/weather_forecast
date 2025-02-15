import 'package:jiffy/jiffy.dart';

extension FormatDateTime on DateTime {
  String get dateTime =>
      Jiffy.parseFromDateTime(this).format(pattern: 'yMMMMd');
}


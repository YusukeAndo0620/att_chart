import 'package:att_chart/loom/loom_package.dart';

/// カンマ区切り
String getFormattedCommaSeparated({required int value}) {
  final formatter = NumberFormat("#,###");
  return formatter.format(value);
}

/// 正負記号付与
String getFormattedPrefix({required int value}) {
  final prefixTxt = value > 0 ? '+' : '';
  return prefixTxt + value.toString();
}

/// 正負記号付与＋小数点表示
String getFormattedFloat({required double value, int fixedNumber = 2}) {
  final prefixTxt = value > 0 ? '+' : '';
  return '$prefixTxt${value.toStringAsFixed(fixedNumber)}%';
}

/// 時刻表示
String getFormattedDateTime(DateTime date) => '${date.hour}:${date.minute}';

import 'package:flutter/material.dart' hide Theme;
import '../../loom/loom_theme_data.dart';

enum ScreenId {
  chart,
  detail,
}

extension ScreenIdExtension on ScreenId {
  IconData iconData({required LoomThemeData themeData}) {
    switch (this) {
      case ScreenId.chart:
        return themeData.icons.board;
      case ScreenId.detail:
        return themeData.icons.status;
    }
  }
}

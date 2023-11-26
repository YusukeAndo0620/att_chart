import 'package:flutter/material.dart';
import 'screen_id.dart';
import 'app_function.dart';
import 'display_contents.dart';

class App extends AppFunction {
  const App();

  @override
  Widget buildMainContents(context) {
    return const DisplayContents(
      screenId: ScreenId.chart,
    );
  }
}

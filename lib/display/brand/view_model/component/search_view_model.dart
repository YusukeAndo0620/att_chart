import 'package:att_chart/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, TextEditingController>((ref) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<TextEditingController> {
  SearchNotifier()
      : super(
          TextEditingController(text: ''),
        );

  final _logger = attChartLogger(name: 'brand_search');

  void init({required TextEditingController controller}) {
    state = controller;
  }

  void searchBrand({required String keyword}) {
    _logger.d('銘柄検索: $keyword}');

    state = TextEditingController(text: keyword);
  }
}

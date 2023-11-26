import 'dart:async';

import 'package:att_chart/loom/loom_package.dart';
import '../model/brand_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/brand_repository.dart';

class SortInfo {
  const SortInfo({
    required this.sortedIndex,
    required this.isAsc,
  });
  final int sortedIndex;
  final bool isAsc;
}

// Repository(APIの取得)の状態を管理する
final _brandListRepositoryProvider = Provider((ref) => BrandRepository());

/// 銘柄一覧ソート情報
final brandListSortProvider = NotifierProvider<BrandListSort, SortInfo>(() {
  return BrandListSort();
});

class BrandListSort extends Notifier<SortInfo> {
  @override
  SortInfo build() {
    return const SortInfo(sortedIndex: 0, isAsc: false);
  }

  void setSortInfo({required int columnIndex, required bool isAsc}) {
    state = SortInfo(sortedIndex: columnIndex, isAsc: isAsc);
  }
}

// 銘柄一覧データ
final brandListProvider =
    AsyncNotifierProvider<BrandListNotifier, List<BrandBaseInfo>>(
        BrandListNotifier.new);

class BrandListNotifier extends AsyncNotifier<List<BrandBaseInfo>> {
  final _logger = attChartLogger(name: 'brand_list');
  @override
  FutureOr<List<BrandBaseInfo>> build() async {
    _logger.d('BrandListNotifier: 初期化');
    return await getBrandList();
  }

  /// データの取得メソッド
  Future<List<BrandBaseInfo>> getBrandList() async {
    _logger.d('BrandListNotifier: 銘柄取得');
    final repository = ref.read(_brandListRepositoryProvider);
    return await repository.getBrandList() ?? [];
  }

  /// 検索
  Future<void> searchList({required String keyword}) async {
    _logger.d('簡易検索実施: keyword: $keyword');
    final data = await getBrandList();
    final List<BrandBaseInfo> targetList = [];
    for (final item in data) {
      if (item.companyId.contains(keyword) ||
          item.companyName.contains(keyword)) {
        targetList.add(item);
      }
    }
    _logger.d('検索結果: $targetList');
    //銘柄一覧更新
    update((data) {
      state = const AsyncLoading();
      return data = targetList;
    }, onError: (error, stack) {
      state = AsyncError(error, stack);
      throw Exception(error);
    });
  }

  /// ソート処理
  void sortList({required int columnIndex, required bool isAscending}) {
    _logger.d('ソート処理実施: columnIndex: $columnIndex, isAscending:$isAscending');
    final targetList = state.asData!.value;
    final brandListSort = ref.watch(brandListSortProvider);
    var isAsc = columnIndex == brandListSort.sortedIndex
        ? !brandListSort.isAsc
        : isAscending;

    switch (columnIndex) {
      case 0:
        targetList.sort(
          (a, b) => isAsc
              ? b.companyName.compareTo(a.companyName)
              : a.companyName.compareTo(b.companyName),
        );
      case 1:
        targetList.sort(
          (a, b) =>
              isAsc ? b.price.compareTo(a.price) : a.price.compareTo(b.price),
        );
      case 2:
        targetList.sort(
          (a, b) => isAsc
              ? b.differenceValue.compareTo(a.differenceValue)
              : a.differenceValue.compareTo(b.differenceValue),
        );
    }

    //ソード情報更新
    ref
        .watch(brandListSortProvider.notifier)
        .setSortInfo(columnIndex: columnIndex, isAsc: isAsc);

    //銘柄一覧更新
    update((data) {
      state = const AsyncLoading();
      return data = targetList;
    }, onError: (error, stack) {
      state = AsyncError(error, stack);
      throw Exception(error);
    });
  }
}

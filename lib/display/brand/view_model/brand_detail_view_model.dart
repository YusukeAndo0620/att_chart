import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/brand_model.dart';
import '../enum/mark_type.dart';
import '../repository/brand_repository.dart';

final initialDetail = BrandDetailInfo(
  companyId: '',
  companyName: '',
  markType: MarkType.gap,
  time: DateTime.now(),
  price: 0,
  differenceValue: 0,
  ratio: 0,
  closingPrice: 0,
  startingPrice: 0,
  highPrice: 0,
  lowPrice: 0,
  volume: 0,
  purchasePrice: 0,
  marketPrice: 0,
  basUnit: 0,
  chartList: [],
);

// Repository(APIの取得)の状態を管理する
final brandDetailRepositoryProvider = Provider((ref) => BrandRepository());

// 上記を非同期で管理する
final brandDetailProvider =
    FutureProvider.autoDispose.family<BrandDetailInfo, String>(
  (ref, companyId) async {
    final repository = ref.read(brandDetailRepositoryProvider);
    return await repository.getBrandDetail(companyId: companyId) ??
        initialDetail;
  },
);

import 'package:att_chart/loom/loom_package.dart';

import '../model/brand_model.dart';

class BrandRepository {
  BrandRepository();

  final _logger = attChartLogger(name: 'brand_repository');

  /// 銘柄一覧取得
  Future<List<BrandBaseInfo>?> getBrandList() async {
    // final Dio dio = Dio();
    // const url = 'https://xxxxxxx';
    // API通信結果
    // final response = await dio.get(url);
    // if (response.statusCode == 200) {
    try {
      _logger.i('getBrandList通信開始');
      // final responseData = response.data;
      //TODO: 仮データで上書き
      final responseData = await rootBundle.loadString('json/list_dummy.json');
      _logger.i('取得データ：$responseData');

      final jsonResponse = json.decode(responseData)["brandList"];
      final List<dynamic> dataList = jsonResponse.toList();

      final List<BrandBaseInfo> brandList = [];

      for (final data in dataList) {
        final model = BrandBaseInfo.fromJson(data);
        brandList.add(model);
      }
      return brandList;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getBrandList通信終了');
    }
    // }
  }

  /// 銘柄詳細取得
  Future<BrandDetailInfo?> getBrandDetail({required String companyId}) async {
    // final Dio dio = Dio();
    // const url = 'https://xxxxxxx';
    // API通信結果
    // final response = await dio.get(url);
    // if (response.statusCode == 200) {
    try {
      _logger.i('getBrandDetail通信開始');
      // final responseData = response.data;
      //TODO: 仮データで上書き
      final responseData =
          await rootBundle.loadString('json/detail_dummy.json');
      _logger.i('取得データ：$responseData');

      final jsonResponse = json.decode(responseData)["brandList"];
      final List<dynamic> dataList = jsonResponse.toList();
      final targetData =
          dataList.firstWhere((item) => item["companyId"] == companyId);

      return BrandDetailInfo.fromJson(targetData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getBrandDetail通信終了');
    }
    // }
  }
}

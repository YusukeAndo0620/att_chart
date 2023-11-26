import '../enum/mark_type.dart';
import 'package:att_chart/loom/loom_package.dart';

class BrandBaseInfo {
  BrandBaseInfo({
    required this.companyId,
    required this.companyName,
    required this.markType,
    required this.time,
    required this.price,
    required this.differenceValue,
    required this.ratio,
  });

  final String companyId;
  final String companyName;
  final MarkType markType;
  final DateTime time;
  final int price;
  final int differenceValue;
  final double ratio;

  factory BrandBaseInfo.fromJson(dynamic json) {
    final companyId = json['companyId'];
    final companyName = json['companyName'];
    final markType = getMarkType(value: json['markType']);
    final time = DateTime.parse(json['time']);
    final price = json['price'];
    final differenceValue = json['differenceValue'];

    final model = BrandBaseInfo(
      companyId: companyId,
      companyName: companyName,
      markType: markType,
      time: time,
      price: price,
      differenceValue: differenceValue,
      ratio: (differenceValue / price * 100),
    );

    return model;
  }
}

class ChartInfo {
  ChartInfo({
    required this.lowPrice,
    required this.highPrice,
  });

  /// 安値
  final int lowPrice;

  /// 高値
  final int highPrice;
}

class BrandDetailInfo extends BrandBaseInfo {
  BrandDetailInfo({
    required super.companyId,
    required super.companyName,
    required super.markType,
    required super.time,
    required super.price,
    required super.differenceValue,
    required super.ratio,
    required this.closingPrice,
    required this.startingPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
    required this.purchasePrice,
    required this.marketPrice,
    required this.basUnit,
    required this.chartList,
  });

  /// 前日終値
  final int closingPrice;

  /// 始値
  final int startingPrice;

  /// 高値
  final int highPrice;

  /// 安値
  final int lowPrice;

  /// 出来高
  final int volume;

  /// 売買代金
  final int purchasePrice;

  /// 時価
  final int marketPrice;

  /// 売買単元
  final int basUnit;

  /// チャート情報
  final List<KLineEntity> chartList;

  factory BrandDetailInfo.fromJson(dynamic json) {
    final companyId = json['companyId'];
    final companyName = json['companyName'];
    final markType = getMarkType(value: json['markType']);
    final time = DateTime.parse(json['time']);
    final price = json['price'];
    final differenceValue = json['differenceValue'];
    final closingPrice = json['closingPrice'];
    final startingPrice = json['startingPrice'];
    final highPrice = json['highPrice'];
    final lowPrice = json['lowPrice'];
    final volume = json['volume'];
    final purchasePrice = json['purchasePrice'];
    final marketPrice = json['marketPrice'];
    final basUnit = json['basUnit'];

    final List<KLineEntity> chartList = [];

    final chartData = json['chartInfo'];
    for (final item in chartData) {
      final targetChartInfo = KLineEntity.fromJson(item);
      chartList.add(targetChartInfo);
    }

    final model = BrandDetailInfo(
      companyId: companyId,
      companyName: companyName,
      markType: markType,
      time: time,
      price: price,
      differenceValue: differenceValue,
      ratio: (differenceValue / price * 100),
      closingPrice: closingPrice,
      startingPrice: startingPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      volume: volume,
      purchasePrice: purchasePrice,
      marketPrice: marketPrice,
      basUnit: basUnit,
      chartList: chartList,
    );

    return model;
  }
}

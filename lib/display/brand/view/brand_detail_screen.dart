import 'package:att_chart/display/brand/enum/mark_type.dart';
import 'package:att_chart/display/brand/view/component/brand_card.dart';
import 'package:att_chart/display/brand/view/component/candle_chart.dart';
import 'package:att_chart/display/brand/view/component/record_item.dart';
import 'package:att_chart/display/common/utils.dart';
import 'package:att_chart/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/brand_detail_view_model.dart';

const _kClosingPriceTxt = '前日終値';
const _kStartingPriceTxt = '始値';
const _kHighPriceTxt = '高値';
const _kLowPriceTxt = '安値';
const _kVolumeTxt = '出来高';
const _kPurchasePriceTxt = '売買代金';
const _kMarketPriceTxt = '時価';
const _kBasUnitTxt = '売買単元';

const _kCardColumnSpace = 8.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0);

class BrandDetailScreen extends ConsumerWidget {
  const BrandDetailScreen({
    super.key,
    required this.companyId,
  });

  final String companyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final brandDetail = ref.watch(brandDetailProvider(companyId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          companyId,
          style: theme.textStyleHeading.copyWith(color: theme.colorFgDefault),
        ),
      ),
      body: Container(
        padding: _kContentPadding,
        color: theme.colorBgLayer1,
        child: brandDetail.when(
          data: (info) {
            return Column(
              children: [
                BrandCard(
                  companyId: info.companyId,
                  companyName: info.companyName,
                  markText: '東${info.markType.text}',
                  price: getFormattedCommaSeparated(value: info.price),
                  time: getFormattedDateTime(info.time),
                  differenceValue:
                      getFormattedPrefix(value: info.differenceValue),
                  ratio: getFormattedFloat(value: info.ratio),
                  isPositive: info.differenceValue > 0,
                ),
                const SizedBox(
                  height: _kCardColumnSpace,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RecordItem(
                                    title: _kClosingPriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.closingPrice),
                                  ),
                                  RecordItem(
                                    title: _kStartingPriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.startingPrice),
                                  ),
                                  RecordItem(
                                    title: _kHighPriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.highPrice),
                                  ),
                                  RecordItem(
                                    title: _kLowPriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.lowPrice),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RecordItem(
                                    title: _kVolumeTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.volume),
                                  ),
                                  RecordItem(
                                    title: _kPurchasePriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.purchasePrice),
                                  ),
                                  RecordItem(
                                    title: _kMarketPriceTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.marketPrice),
                                  ),
                                  RecordItem(
                                    title: _kBasUnitTxt,
                                    content: getFormattedCommaSeparated(
                                        value: info.basUnit),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: _kCardColumnSpace,
                        ),
                        CandleChart(
                          companyId: companyId,
                          chartList: info.chartList,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Align(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Align(child: Text(error.toString())),
        ),
      ),
    );
  }
}

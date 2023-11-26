import 'package:att_chart/display/brand/view/component/column/company_column.dart';
import 'package:att_chart/display/brand/view/component/column/ratio_column.dart';
import 'package:att_chart/display/common/utils.dart';
import 'package:att_chart/loom/loom_package.dart';

import '../../enum/mark_type.dart';
import '../../../common/component/tap_action.dart';

const _kContentPadding = EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0);
const _kColumnSpace = 30.0;
const _kBorderWidth = 1.0;

class BrandListItem extends StatelessWidget {
  const BrandListItem({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.markType,
    required this.time,
    required this.price,
    required this.differenceValue,
    required this.ratio,
    required this.onTap,
  });
  final String companyId;
  final String companyName;
  final MarkType markType;
  final DateTime time;
  final int price;
  final int differenceValue;
  final double ratio;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return TapAction(
      key: ValueKey(companyId),
      width: double.infinity,
      tappedColor: theme.colorPrimary.withOpacity(0.7),
      onTap: () => onTap(companyId),
      widget: Container(
        padding: _kContentPadding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorFgDefault,
              width: _kBorderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CompanyColumn(
                companyId: companyId,
                companyName: companyName,
                markText: '東${markType.text}',
                time: getFormattedDateTime(time),
                isPositive: differenceValue > 0),
            const SizedBox(
              width: _kColumnSpace,
            ),
            Text(
              getFormattedCommaSeparated(value: price),
              style: theme.textStyleBody,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              width: _kColumnSpace,
            ),
            RatioColumn(
              differenceValue: getFormattedPrefix(value: differenceValue),
              ratio: getFormattedFloat(value: ratio),
              color: differenceValue > 0
                  ? theme.colorFgStrong
                  : theme.colorDangerDefault,
            ),
          ],
        ),
      ),
    );
  }
}

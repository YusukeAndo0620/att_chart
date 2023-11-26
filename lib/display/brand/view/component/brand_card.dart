import 'package:att_chart/display/brand/view/component/column/company_column.dart';
import 'package:att_chart/display/brand/view/component/column/ratio_column.dart';
import 'package:att_chart/loom/loom_package.dart';

const _kCompanyNameColumnWidth = 300.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.markText,
    required this.time,
    required this.price,
    required this.differenceValue,
    required this.ratio,
    required this.isPositive,
  });

  final String companyId;
  final String companyName;
  final String markText;
  final String time;
  final String price;
  final String differenceValue;
  final String ratio;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      color: theme.colorDisabled.withOpacity(0.4),
      padding: _kContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CompanyColumn(
            width: _kCompanyNameColumnWidth,
            companyId: companyId,
            companyName: companyName,
            markText: markText,
            time: time,
            isPositive: isPositive,
          ),
          RatioColumn(
            differenceValue: differenceValue,
            ratio: ratio,
            color: isPositive ? theme.colorFgStrong : theme.colorDangerDefault,
          ),
        ],
      ),
    );
  }
}

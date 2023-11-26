import 'package:att_chart/loom/loom_package.dart';

const _kCompanyNameColumnSpace = 16.0;
const _kCompanyNameColumnWidth = 200.0;
const _kPrefixStickWidth = 8.0;
const _kPrefixStickHeight = 35.0;

class CompanyColumn extends StatelessWidget {
  const CompanyColumn({
    super.key,
    this.width = _kCompanyNameColumnWidth,
    required this.companyId,
    required this.companyName,
    required this.markText,
    required this.time,
    required this.isPositive,
  });

  final double width;
  final String companyId;
  final String companyName;
  final String markText;
  final String time;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Row(
      children: [
        SizedBox(
          width: _kPrefixStickWidth,
          height: _kPrefixStickHeight,
          child: VerticalDivider(
            thickness: 4,
            color: isPositive ? theme.colorFgStrong : theme.colorDangerDefault,
          ),
        ),
        const SizedBox(
          width: _kCompanyNameColumnSpace,
        ),
        SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: theme.textStyleBody,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    companyId,
                    style: theme.textStyleFootnote,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: _kCompanyNameColumnSpace,
                  ),
                  Text(
                    markText,
                    style: theme.textStyleFootnote,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: _kCompanyNameColumnSpace,
                  ),
                  Text(
                    time,
                    style: theme.textStyleFootnote,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

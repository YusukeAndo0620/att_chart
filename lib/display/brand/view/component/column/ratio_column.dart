import 'package:att_chart/loom/loom_package.dart';

class RatioColumn extends StatelessWidget {
  const RatioColumn({
    super.key,
    required this.differenceValue,
    required this.ratio,
    required this.color,
  });

  final String differenceValue;
  final String ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          differenceValue,
          style: theme.textStyleBody.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          ratio,
          style: theme.textStyleBody.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

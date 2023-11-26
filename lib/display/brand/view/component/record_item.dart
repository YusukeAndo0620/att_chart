import 'package:att_chart/loom/loom_package.dart';

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      color: theme.colorDisabled.withOpacity(0.2),
      padding: _kContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textStyleBody,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            content ?? '-',
            style: theme.textStyleBody,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

import 'package:att_chart/loom/loom_package.dart';
import '../display/brand/view/brand_list_screen.dart';

const _kFooterButtons = [
  _FooterInfo(
    screenId: ScreenId.chart,
    title: 'チャート',
    buildWidget: BrandListScreen(),
  ),
  _FooterInfo(
    screenId: ScreenId.detail,
    title: '詳細',
    buildWidget: SizedBox(),
  ),
];

const _kAppBarTitle = 'Att Chart';

class DisplayContents extends StatefulWidget {
  const DisplayContents({super.key, required this.screenId});

  final ScreenId screenId;
  @override
  State<StatefulWidget> createState() => _DisplayContentsState();
}

class _DisplayContentsState extends State<DisplayContents> {
  var selectedScreenId = ScreenId.chart;

  @override
  void initState() {
    super.initState();
    selectedScreenId = widget.screenId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          _kAppBarTitle,
          style: theme.textStyleHeading,
        ),
      ),
      body: Container(
        color: theme.colorBgLayer1,
        child: _kFooterButtons
            .firstWhere((element) => element.screenId == selectedScreenId)
            .buildWidget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorBgLayer1,
        currentIndex: _kFooterButtons.indexOf(_kFooterButtons
            .firstWhere((element) => element.screenId == selectedScreenId)),
        showUnselectedLabels: true,
        selectedItemColor: theme.colorPrimary,
        unselectedItemColor: theme.colorFgDisabled,
        items: [
          for (final footerInfo in _kFooterButtons)
            BottomNavigationBarItem(
              icon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              activeIcon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              label: footerInfo.title,
              tooltip: footerInfo.title,
            ),
        ],
        onTap: (value) => _onTapIcon(index: value),
      ),
    );
  }

  void _onTapIcon({required int index}) {
    setState(() {
      selectedScreenId = _kFooterButtons[index].screenId;
    });
  }
}

class _FooterInfo {
  const _FooterInfo({
    required this.screenId,
    required this.title,
    required this.buildWidget,
  });
  final ScreenId screenId;
  final String title;
  final Widget buildWidget;
}

import 'package:att_chart/loom/loom_package.dart';

const _kContentPadding = EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0);

class CandleChart extends StatefulWidget {
  const CandleChart({
    super.key,
    required this.companyId,
    required this.chartList,
  });

  final String companyId;
  final List<KLineEntity> chartList;
  @override
  CandleChartState createState() => CandleChartState();
}

class CandleChartState extends State<CandleChart> {
  List<KLineEntity>? chartList;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = true;
  bool _hideGrid = false;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = false;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.left;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    chartList = widget.chartList;
    showLoading = false;
    // getData('1day');
    // rootBundle.loadString('assets/depth.json').then((result) {
    //   final parseJson = json.decode(result);
    //   final tick = parseJson['tick'] as Map<String, dynamic>;
    //   final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
    //       .map<DepthEntity>(
    //           (item) => DepthEntity(item[0] as double, item[1] as double))
    //       .toList();
    //   final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
    //       .map<DepthEntity>(
    //           (item) => DepthEntity(item[0] as double, item[1] as double))
    //       .toList();
    //   initDepth(bids, asks);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    });

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: KChartWidget(
              chartList,
              chartStyle,
              chartColors,
              isLine: isLine,
              onSecondaryTap: () {
                print('Secondary Tap');
              },
              isTrendLine: _isTrendLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              translations: kChartTranslations,
              showNowPrice: _showNowPrice,
              hideGrid: _hideGrid,
              isTapShowInfoDialog: false,
              verticalTextAlignment: _verticalTextAlignment,
              maDayList: const [1, 100, 1000],
            ),
          ),
          if (showLoading)
            Container(
                width: double.infinity,
                height: 450,
                alignment: Alignment.center,
                child: const CircularProgressIndicator()),
        ]),
        buildButtons(),
        if (_bids != null && _asks != null)
          Container(
            height: 230,
            width: double.infinity,
            child: DepthChart(_bids!, _asks!, chartColors),
          )
      ],
    );
  }

  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: <Widget>[
        button(
          "Time Mode",
          onPressed: () => setState(
            () {
              isLine = true;
            },
          ),
        ),
        button(
          "K Line Mode",
          onPressed: () => setState(
            () {
              isLine = false;
            },
          ),
        ),
        button(
          "TrendLine",
          onPressed: () => setState(
            () {
              _isTrendLine = !_isTrendLine;
            },
          ),
        ),
        button(
          "Line:MA",
          onPressed: () => setState(
            () {
              _mainState = MainState.MA;
            },
          ),
        ),
        button(
          "Line:BOLL",
          onPressed: () => setState(
            () {
              _mainState = MainState.BOLL;
            },
          ),
        ),
        button(
          "Hide Line",
          onPressed: () => setState(
            () {
              _mainState = MainState.NONE;
            },
          ),
        ),
        button(
          "Secondary Chart:MACD",
          onPressed: () => setState(
            () {
              _secondaryState = SecondaryState.MACD;
            },
          ),
        ),
        button(
          "Secondary Chart:KDJ",
          onPressed: () => setState(
            () {
              isLine = true;
              _secondaryState = SecondaryState.KDJ;
            },
          ),
        ),
        button(
          "Secondary Chart:RSI",
          onPressed: () => setState(
            () {
              _secondaryState = SecondaryState.RSI;
            },
          ),
        ),
        button(
          "Secondary Chart:WR",
          onPressed: () => setState(
            () {
              _secondaryState = SecondaryState.WR;
            },
          ),
        ),
        button(
          "Secondary Chart:CCI",
          onPressed: () => setState(
            () {
              _secondaryState = SecondaryState.CCI;
            },
          ),
        ),
        button(
          "Secondary Chart:Hide",
          onPressed: () => setState(
            () {
              _secondaryState = SecondaryState.NONE;
            },
          ),
        ),
        button(
          _volHidden ? "Show Vol" : "Hide Vol",
          onPressed: () => setState(
            () {
              _volHidden = !_volHidden;
            },
          ),
        ),
        button(
          "Change Language",
          onPressed: () => setState(
            () {
              isChinese = !isChinese;
            },
          ),
        ),
        button(
          _hideGrid ? "Show Grid" : "Hide Grid",
          onPressed: () => setState(
            () {
              _hideGrid = !_hideGrid;
            },
          ),
        ),
        button(
          _showNowPrice ? "Hide Now Price" : "Show Now Price",
          onPressed: () => setState(
            () {
              _showNowPrice = !_showNowPrice;
            },
          ),
        ),
        button("Customize UI", onPressed: () {
          setState(() {
            isChangeUI = !isChangeUI;
            if (isChangeUI) {
              chartColors.selectBorderColor = Colors.red;
              chartColors.selectFillColor = Colors.red;
              chartColors.lineFillColor = Colors.red;
              chartColors.kLineColor = Colors.yellow;
            } else {
              chartColors.selectBorderColor = Color(0xff6C7A86);
              chartColors.selectFillColor = Color(0xff0D1722);
              chartColors.lineFillColor = Color(0x554C86CD);
              chartColors.kLineColor = Color(0xff4C86CD);
            }
          });
        }),
        button(
          "Change PriceTextPaint",
          onPressed: () => setState(
            () {
              _priceLeft = !_priceLeft;
              if (_priceLeft) {
                _verticalTextAlignment = VerticalTextAlignment.left;
              } else {
                _verticalTextAlignment = VerticalTextAlignment.right;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    final theme = LoomTheme.of(context);
    return Padding(
      padding: _kContentPadding,
      child: TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        style: TextButton.styleFrom(
          fixedSize: const Size(120, 44),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          backgroundColor: Colors.blue,
        ),
        child: Text(
          text,
          style: theme.textStyleBody,
        ),
      ),
    );
  }

  // void getData(String period) {
  //   final Future<String> future = getChatDataFromInternet(period);
  //   //final Future<String> future = getChatDataFromJson();
  //   future.then((String result) {
  //     solveChatData(result);
  //   }).catchError((_) {
  //     showLoading = false;
  //     setState(() {});
  //     print('### datas error $_');
  //   });
  // }

  //获取火币数据，需要翻墙
  // Future<String> getChatDataFromInternet(String? period) async {
  //   var url =
  //       'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
  //   late String result;
  //   final Dio dio = Dio();
  //   final response = await dio.get(url);
  //   if (response.statusCode == 200) {
  //     result = response.data.body;
  //   } else {
  //     print('Failed getting IP address');
  //   }
  //   return result;
  // }

  // // 如果你不能翻墙，可以使用这个方法加载数据
  // Future<String> getChatDataFromJson() async {
  //   return rootBundle.loadString('assets/chatData.json');
  // }

  // void solveChatData(String result) {
  //   final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
  //   final list = parseJson['data'] as List<dynamic>;
  //   datas = list
  //       .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
  //       .toList()
  //       .reversed
  //       .toList()
  //       .cast<KLineEntity>();
  //   DataUtil.calculate(datas!);
  //   showLoading = false;
  //   setState(() {});
  // }
}

import 'package:att_chart/display/brand/enum/mark_type.dart';
import 'package:att_chart/display/brand/view/brand_detail_screen.dart';
import 'package:att_chart/display/brand/view/component/column/company_column.dart';
import 'package:att_chart/display/brand/view/component/column/ratio_column.dart';
import 'package:att_chart/display/common/utils.dart';
import 'package:att_chart/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/brand_list_view_model.dart';
import 'component/brand_search.dart';

const _kSearchHintTxt = '銘柄名 or 銘柄コード';
const _kBrandHeaderTxt = '銘柄名';
const _kPriceHeaderTxt = '現在値';
const _kRatioHeaderTxt = '前日比';
const _kColumnSpace = 30.0;
const _kHeaderColumnWidth = 50.0;

class BrandListScreen extends ConsumerWidget {
  const BrandListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final brandList = ref.watch(brandListProvider);
    final brandListSort = ref.watch(brandListSortProvider);

    return SizedBox(
      child: brandList.when(
        data: (list) {
          return Column(
            children: [
              BrandSearch(
                textController: TextEditingController(text: ''),
                hintText: _kSearchHintTxt,
                autoFocus: false,
                icon: Icon(
                  theme.icons.search,
                  color: theme.colorPrimary,
                ),
                onSubmitted: (value) {
                  ref
                      .watch(brandListProvider.notifier)
                      .searchList(keyword: value);
                },
              ),
              const SizedBox(height: _kColumnSpace),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                        return theme.colorDisabled
                            .withOpacity(0.3); // Use the default value.
                      }),
                      sortColumnIndex: brandListSort.sortedIndex,
                      sortAscending: brandListSort.isAsc,
                      showCheckboxColumn: false,
                      columns: <DataColumn>[
                        DataColumn(
                          label: SizedBox(
                            width: _kHeaderColumnWidth,
                            child: Text(
                              _kBrandHeaderTxt,
                              style: theme.textStyleBody,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onSort: (columnIndex, isAscending) {
                            ref.watch(brandListProvider.notifier).sortList(
                                columnIndex: columnIndex,
                                isAscending: isAscending);
                          },
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: _kHeaderColumnWidth,
                            child: Text(
                              _kPriceHeaderTxt,
                              style: theme.textStyleBody,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onSort: (columnIndex, isAscending) {
                            ref.watch(brandListProvider.notifier).sortList(
                                columnIndex: columnIndex,
                                isAscending: isAscending);
                          },
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: _kHeaderColumnWidth,
                            child: Text(
                              _kRatioHeaderTxt,
                              style: theme.textStyleBody,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onSort: (columnIndex, isAscending) {
                            ref.watch(brandListProvider.notifier).sortList(
                                columnIndex: columnIndex,
                                isAscending: isAscending);
                          },
                        ),
                      ],
                      rows: [
                        for (final item in list) ...[
                          DataRow(
                            onSelectChanged: (val) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BrandDetailScreen(
                                      companyId: item.companyId,
                                    );
                                  },
                                ),
                              );
                            },
                            cells: <DataCell>[
                              DataCell(
                                CompanyColumn(
                                    companyId: item.companyId,
                                    companyName: item.companyName,
                                    markText: '東${item.markType.text}',
                                    time: getFormattedDateTime(item.time),
                                    isPositive: item.differenceValue > 0),
                              ),
                              DataCell(
                                Text(
                                  getFormattedCommaSeparated(value: item.price),
                                  style: theme.textStyleBody,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataCell(
                                RatioColumn(
                                  differenceValue: getFormattedPrefix(
                                      value: item.differenceValue),
                                  ratio: getFormattedFloat(value: item.ratio),
                                  color: item.differenceValue > 0
                                      ? theme.colorFgStrong
                                      : theme.colorDangerDefault,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                // for (final item in list) ...[
                //   BrandListItem(
                //     companyId: item.companyId,
                //     companyName: item.companyName,
                //     markType: item.markType,
                //     time: item.time,
                //     price: item.price,
                //     differenceValue: item.differenceValue,
                //     ratio: item.ratio,
                //     onTap: (companyId) {},
                //   )
                // ]
              ),
            ],
          );
        },
        loading: () => const Align(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Align(child: Text(error.toString())),
      ),
    );
  }
}

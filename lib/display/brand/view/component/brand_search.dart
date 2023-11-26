import 'package:att_chart/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/component/search_view_model.dart';

const _kInputBorderRadius = BorderRadius.all(Radius.circular(10.0));
const _kMaxWidth = 600.0;
const _kBorderWidth = 1.0;

@immutable
class BrandSearch extends ConsumerWidget {
  const BrandSearch({
    super.key,
    this.icon,
    required this.textController,
    this.inputType = TextInputType.text,
    required this.hintText,
    this.maxLength = 100,
    this.autoFocus = false,
    required this.onSubmitted,
  });
  final Icon? icon;
  final TextEditingController textController;
  final TextInputType inputType;
  final String hintText;
  final int maxLength;
  final bool autoFocus;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final textController = ref.watch(searchProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
      child: TextField(
        key: ValueKey(textController.hashCode),
        controller: textController,
        style: theme.textStyleBody,
        maxLength: maxLength,
        cursorColor: theme.colorSecondary,
        keyboardType: inputType,
        textInputAction: TextInputAction.done,
        autofocus: autoFocus,
        onSubmitted: (value) {
          ref.watch(searchProvider.notifier).searchBrand(keyword: value);
          onSubmitted(value);
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {
          ref
              .watch(searchProvider.notifier)
              .searchBrand(keyword: textController.text);
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: icon,
          counterText: '',
          hintStyle: theme.textStyleFootnote,
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: _kInputBorderRadius,
            borderSide: BorderSide(
              width: _kBorderWidth,
              color: theme.colorPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: _kInputBorderRadius,
            borderSide: BorderSide(
              width: _kBorderWidth,
              color: theme.colorFgDisabled,
            ),
          ),
        ),
      ),
    );
  }
}

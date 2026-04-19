
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../theme/common_text_field_copy.dart';
import '../debouncer.dart';
import '../text/common_text.dart';
import 'places_service.dart';

class AddressSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function(PlaceSuggestion suggestion) onSelected;

  final String hintText;

  final Color fillColor;
  final Color borderColor;
  final Color activeBorderColor;

  final Color hintTextColor;
  final Color textColor;
  final Color activeIconColor;

  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderWidth;

  final int maxLines;
  final TextInputAction textInputAction;

  final String? Function(String?)? validator;

  final Widget? prefixIcon;

  const AddressSearchField({
    super.key,
    required this.controller,
    required this.onSelected,
    this.hintText = 'Write address here...',
    this.fillColor = AppColors.white,
    this.borderColor = AppColors.gray200,
    this.activeBorderColor = AppColors.green500,
    this.hintTextColor = AppColors.gray200,
    this.textColor = AppColors.black500,
    this.activeIconColor = AppColors.green500,
    this.borderRadius = 12,
    this.paddingVertical = 14,
    this.paddingHorizontal = 16,
    this.borderWidth = 1,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.prefixIcon,
  });

  @override
  State<AddressSearchField> createState() => _AddressSearchFieldState();
}

class _AddressSearchFieldState extends State<AddressSearchField> {
  final RxList<PlaceSuggestion> _suggestions = <PlaceSuggestion>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isFocused = false.obs;

  late FocusNode _focusNode;

  final _deBouncer = DeBouncer(
    delay: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      _isFocused.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _deBouncer.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _deBouncer(() async {
      if (value.trim().isEmpty) {
        _suggestions.clear();
        return;
      }

      _isLoading.value = true;

      try {
        final results = await PlacesService.getSuggestions(value);
        _suggestions.value = results;
      } finally {
        _isLoading.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// ───────── Search Field ─────────
        Obx(
              () => CommonTextField(
            focusNode: _focusNode,
            controller: widget.controller,
            hintText: widget.hintText,
            onChanged: _onChanged,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            keyboardType: TextInputType.text,
            fillColor: widget.fillColor,
            borderColor: _isFocused.value
                ? widget.activeBorderColor
                : widget.borderColor,
            hintTextColor: widget.hintTextColor,
            textColor: widget.textColor,
            borderRadius: widget.borderRadius,
            paddingVertical: widget.paddingVertical,
            paddingHorizontal: widget.paddingHorizontal,
            borderWidth: widget.borderWidth,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _isLoading.value
                ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ),

        /// ───────── Suggestions Dropdown ─────────
        Obx(() {
          if (!_isFocused.value || _suggestions.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _suggestions.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1),
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];

                return InkWell(
                  borderRadius:
                  BorderRadius.circular(widget.borderRadius),
                  onTap: () {
                    widget.controller.text =
                        suggestion.description;

                    _suggestions.clear();

                    FocusScope.of(context).unfocus();

                    widget.onSelected(suggestion);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: AppColors.green500,
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                textAlign: TextAlign.start,
                                text: suggestion.mainText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: widget.textColor,
                              ),

                              if (suggestion
                                  .secondaryText.isNotEmpty)
                                CommonText(
                                  text: suggestion.secondaryText,
                                  fontSize: 12,
                                  color: widget.hintTextColor,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
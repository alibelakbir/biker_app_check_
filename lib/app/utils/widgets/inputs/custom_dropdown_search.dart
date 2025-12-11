import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownSearch extends StatelessWidget {
  final String title;
  final String hint;
  final List<String> items;
  final dynamic value;
  final Function(dynamic)? onChaged;
  final String textErr;
  final Color? bgColor;
  final TextStyle? titleStyle;
  final double? height;

  const CustomDropdownSearch(
      {super.key,
      required this.title,
      required this.hint,
      required this.items,
      this.value,
      this.onChaged,
      this.textErr = '',
      this.bgColor,
      this.titleStyle,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
                style: titleStyle ??
                    AppTextStyles.base.s12.w500
                        .copyWith(color: AppColors.black))
            .tr(),
        const SizedBox(height: 4),
        Container(
          decoration: dropDownDecoration.copyWith(borderRadius: kRadius4),
          child: DropdownSearch<String>(
              key: Key('d-$title'),
              selectedItem: value,
              items: (filter, infiniteScrollProps) => items,
              filterFn: (item, String? filter) {
                if (filter == null || filter.isEmpty) {
                  return true; // Return all items when the filter is empty
                }
                // Check if the item's string representation starts with the filter string, case-insensitive
                return item
                    .toString()
                    .toLowerCase()
                    .startsWith(filter.toLowerCase());
              },
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  hintText: 'Choisr la marque',
                  hintStyle: AppTextStyles.base.s13.w400.neutral3Color,
                  border: InputBorder.none, // 👈 no border
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                baseStyle: AppTextStyles.base.s13.w400.blackColor,
              ),
              popupProps: PopupProps.menu(
                  showSearchBox: true, // 🔍 enable search
                  searchFieldProps: TextFieldProps(
                      style: AppTextStyles.base.s13.w400.blackColor,
                      decoration: InputDecoration(
                        hintText: "Rechercher...",
                        hintStyle: AppTextStyles.base.s13.w400.neutral3Color,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color(0xFFE6E2EA), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppColors.kPrimaryColor, width: 1),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      )),
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: bgColor ?? Colors.white,
                  ),
                  itemBuilder: (context, item, isDisabled, isSelected) =>
                      ListTile(
                        title: Text(
                          item,
                          style: AppTextStyles.base.s13.w400.blackColor,
                        ),
                      )),
              suffixProps: DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                iconOpened: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.black,
                ),
                iconClosed: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.black,
                ),
              )),
              onChanged: onChaged),
        ),
        if (textErr.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 4),
            child: Text(
              textErr,
              style: AppTextStyles.base.s12.w400.redColor,
            ).tr(),
          ),
      ],
    );
  }
}

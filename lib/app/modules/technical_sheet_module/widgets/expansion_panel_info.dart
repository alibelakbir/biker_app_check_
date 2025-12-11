// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:biker_app/app/modules/technical_sheet_module/model/info_model.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/cupertino.dart';


class ExpansionTileInfo extends StatelessWidget {
  final String title;
  final List<InfoModel> infos;
  const ExpansionTileInfo({super.key, required this.title, required this.infos});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Expandable(
        collapsed: ExpandableButton(
          theme: ExpandableThemeData(inkWellBorderRadius: kRadius10),
          child: _buildHeader(context),
        ),
        expanded: Column(children: [
          ExpandableButton(
              theme: ExpandableThemeData(inkWellBorderRadius: kRadius10),
              child: _buildHeader(context, isExpanded: true)),
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 12),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: infos.length,
            separatorBuilder: (context, index) =>
                Divider(color: Color(0xFFDDDDDD), thickness: 1.5, height: 1.5),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        infos[index].label,
                        style: AppTextStyles.base.s14.w700
                            .copyWith(color: Color(0xFF010101)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        infos[index].text ?? '---',
                        style: AppTextStyles.base.s13.w400
                            .copyWith(color: Color(0xFF6C6C6C)),
                      )),
                ],
              ).paddingSymmetric(vertical: 20);
            },
          ),
        ]),
      ),
    ).paddingSymmetric(horizontal: 16);
  }

  _buildHeader(context, {bool isExpanded = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
          color: isExpanded ? AppColors.kPrimaryColor : Color(0xFFF3F6F6),
          borderRadius: kRadius10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.base.s14.w500.copyWith(
                  color: isExpanded ? AppColors.white : AppColors.black),
            ),
          ),
          Icon(
            isExpanded
                ? CupertinoIcons.chevron_down
                : CupertinoIcons.chevron_back,
            color: isExpanded ? AppColors.white : AppColors.black,
            size: 20,
          )
        ],
      ),
    );
  }
}

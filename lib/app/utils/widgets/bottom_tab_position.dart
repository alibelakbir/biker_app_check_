import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/app_divider/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class BottomTabPosition extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabs;
  const BottomTabPosition(
      {super.key, required this.tabController, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory, // Removes splash effect
        highlightColor: Colors.transparent, // Removes highlight effect
      ),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerHeight: 0,
            labelStyle: AppTextStyles.base.s10.w400,
            tabs: tabs.map((e) => Tab(height: 72, child: e)).toList(),
            labelColor: AppColors.kPrimaryColor,
            unselectedLabelColor: AppColors.black,
            // splashFactory: NoSplash.splashFactory,
            indicator: MaterialIndicator(
              color: AppColors.kPrimaryColor,
              height: 3,
              topLeftRadius: 8,
              topRightRadius: 8,
              horizontalPadding: 8,
              tabPosition: TabPosition.bottom,
            ),
          ),
          AppDivider(
            color: Color.fromRGBO(217, 217, 217, 0.4),
          )
        ],
      ),
    );
  }
}

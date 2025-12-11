import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';

import '../models/menu.dart';
import 'package:flutter/cupertino.dart';


class MenuItem extends StatelessWidget {
  final Menu menu;
  const MenuItem({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: menu.onTap,
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFFEAEAEA), width: 1.0))),
        child: Row(
          spacing: 16,
          children: [
            menu.icon,
            Expanded(
                child: Text(menu.label,
                    style: AppTextStyles.base.s16.copyWith(
                      fontWeight:
                          menu.isDanger ? FontWeight.w500 : FontWeight.w400,
                      color:
                          menu.isDanger ? Color(0xFFFF0000) : AppColors.black,
                      decoration:
                          menu.isDanger ? TextDecoration.underline : null,
                      decorationColor: menu.isDanger ? Color(0xFFFF0000) : null,
                    ))),
            Icon(
              CupertinoIcons.forward,
              color: AppColors.black,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

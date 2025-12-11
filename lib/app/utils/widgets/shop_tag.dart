import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/widgets.dart';

class ShopTag extends StatelessWidget {
  const ShopTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration:
          BoxDecoration(color: Color(0xFFFEBC32), borderRadius: kRadius10),
      child: Text(
        'Boutique',
        style: AppTextStyles.base.s12.w900.whiteColor,
      ),
    );
  }
}

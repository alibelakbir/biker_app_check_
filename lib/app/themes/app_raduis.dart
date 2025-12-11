import 'package:flutter/widgets.dart';

import 'app_colors.dart';

const kRadius2 = BorderRadius.all(Radius.circular(2.0));

const kRadius4 = BorderRadius.all(Radius.circular(4.0));

const kRadius5 = BorderRadius.all(Radius.circular(5.0));

const kRadius6 = BorderRadius.all(Radius.circular(6.0));

const kRadius8 = BorderRadius.all(Radius.circular(8.0));

const kRadius10 = BorderRadius.all(Radius.circular(10.0));

const kRadius12 = BorderRadius.all(Radius.circular(12.0));

const kRadius14 = BorderRadius.all(Radius.circular(14.0));

const kRadius16 = BorderRadius.all(Radius.circular(16.0));

const kRadius20 = BorderRadius.all(Radius.circular(20.0));

const kRadius25 = BorderRadius.all(Radius.circular(25.0));

const kRadius50 = BorderRadius.all(Radius.circular(50.0));

const kRadius100 = BorderRadius.all(Radius.circular(100.0));

const kHorizontalRadius = BorderRadius.horizontal(
    left: Radius.circular(20.0), right: Radius.circular(20.0));

const kVerticalRadius = BorderRadius.vertical(
    top: Radius.circular(20.0), bottom: Radius.circular(20.0));

const kTopRadius = BorderRadius.only(
    topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0));

const kTopRadius10 = BorderRadius.only(
    topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0));

const kTopRadius20 = BorderRadius.only(
    topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0));

const kBottomRadius = BorderRadius.only(
    bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0));

const kBottomRadius24 = BorderRadius.only(
    bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0));

const kBottomRadius32 = BorderRadius.only(
    bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0));

const kBottomRadius55 = BorderRadius.only(
    bottomLeft: Radius.circular(55.0), bottomRight: Radius.circular(55.0));

const kBottomRadius12 = BorderRadius.only(
    bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0));

const kLeftRadius = BorderRadius.only(
    topLeft: Radius.circular(20), bottomLeft: Radius.circular(20));

const kRightRadius = BorderRadius.only(
    topRight: Radius.circular(6), bottomRight: Radius.circular(6));

const kCardShadow = BoxShadow(
  color: Color(0x0F000000), // #0000000F → 6% opacity black
  offset: Offset(0, 1), // x: 0, y: 1
  blurRadius: 5.1, // blur amount
  spreadRadius: 0, // no spread
);
const kDarkCardShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 65, offset: Offset(0, 4));

const kCircularDeleteShadow = BoxShadow(
  color: Color.fromRGBO(250, 49, 49, 0.25), // Color with 25% opacity
  offset: Offset(0, 4), // Horizontal and Vertical offset
  blurRadius: 15, // Blur radius
  spreadRadius: 0, // Spread radius
);

BoxDecoration kDarkCardDecoration = BoxDecoration(
  color: const Color(0xFF1C1C34),
  borderRadius: kRadius5,
  border: Border.all(width: 1, color: const Color(0xFF39395C)),
  boxShadow: const [kDarkCardShadow],
);
BoxDecoration kLightCardDecoration = const BoxDecoration(
    color: AppColors.white, borderRadius: kRadius10, boxShadow: [kCardShadow]);

BoxDecoration kRoomDeco = const BoxDecoration(
  color: AppColors.white,
  borderRadius: kRadius16,
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // rgba(0, 0, 0, 0.05)
      offset: Offset(0, 5), // x: 0px, y: 5px
      blurRadius: 30, // blur
      spreadRadius: 0, // spread
    ),
  ],
);

BoxDecoration dropDownDecoration = kLightCardDecoration.copyWith(
  borderRadius: kRadius8,
  border: Border.all(width: 1, color: const Color(0xFFE6E2EA)),
  boxShadow: null,
);

BoxDecoration checkBoxDecoration = BoxDecoration(
  color: AppColors.kPrimaryColor,
  borderRadius: kRadius4,
);
BoxDecoration uncheckBoxDecoration = BoxDecoration(
  color: AppColors.white.withOpacity(0.2),
  borderRadius: kRadius4,
  border: Border.all(
    width: 1,
    color: const Color(0xFFCECECE),
  ),
);

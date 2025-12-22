import 'package:biker_app/app/modules/congratulations_page.dart';
import 'package:biker_app/app/modules/notification_module/notification_binding.dart';
import 'package:biker_app/app/modules/notification_module/notification_page.dart';
import 'package:biker_app/app/modules/filter_module/filter_page.dart';
import 'package:biker_app/app/modules/change_password_module/change_password_binding.dart';
import 'package:biker_app/app/modules/change_password_module/change_password_page.dart';
import 'package:biker_app/app/modules/reset_password_module/reset_password_binding.dart';
import 'package:biker_app/app/modules/reset_password_module/reset_password_page.dart';
import 'package:biker_app/app/modules/chat_module/chat_binding.dart';
import 'package:biker_app/app/modules/chat_module/chat_page.dart';
import 'package:biker_app/app/modules/my_profile_module/edit_profile_page.dart';
import 'package:biker_app/app/modules/my_profile_module/my_profile_binding.dart';
import 'package:biker_app/app/modules/my_profile_module/my_profile_page.dart';
import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_binding.dart';
import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_page.dart';
import 'package:biker_app/app/modules/photo_view_page.dart';
import 'package:biker_app/app/modules/splash_module/spalsh_binding.dart';
import 'package:biker_app/app/modules/web_view.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_binding.dart';
import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_page.dart';
import 'package:biker_app/app/modules/auth_module/auth_binding.dart';
import 'package:biker_app/app/modules/auth_module/auth_page.dart';
import 'package:biker_app/app/modules/technical_sheet_module/technical_sheet_binding.dart';
import 'package:biker_app/app/modules/shop_details_module/shop_details_binding.dart';
import 'package:biker_app/app/modules/profile_module/profile_binding.dart';
import 'package:biker_app/app/modules/profile_module/profile_page.dart';
import 'package:biker_app/app/modules/listing_moto_module/listing_moto_binding.dart';
import 'package:biker_app/app/modules/listing_moto_module/listing_moto_page.dart';
import 'package:biker_app/app/modules/brand_details_module/brand_details_binding.dart';
import 'package:biker_app/app/modules/brand_module/brand_binding.dart';
import 'package:biker_app/app/modules/brand_module/brand_page.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_binding.dart';
import 'package:biker_app/app/modules/dashboard_module/dashboard_binding.dart';
import 'package:biker_app/app/modules/dashboard_module/dashboard_page.dart';
import 'package:biker_app/app/modules/home_module/home_binding.dart';
import 'package:biker_app/app/modules/home_module/home_page.dart';
import 'package:biker_app/app/modules/splash_module/splash_page.dart';
part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
        name: AppRoutes.advertisementDetails,
        page: () {
          final ad = Get.arguments;
          return ad;
        },
        binding: AdvertisementDetailsBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: AppRoutes.brand,
      page: () => const BrandPage(),
      binding: BrandBinding(),
    ),
    GetPage(
      name: AppRoutes.brandDetails,
      page: () {
        final brand = Get.arguments;
        return brand;
      },
      binding: BrandDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.listingMoto,
      page: () => const ListingMotoPage(),
      binding: ListingMotoBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.shopDetails,
      page: () {
        final shop = Get.arguments;
        return shop;
      },
      binding: ShopDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.technicalSheet,
      page: () {
        final ad = Get.arguments;
        return ad;
      },
      binding: TechnicalSheetBinding(),
    ),
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.newAdvertisement,
      page: () => const NewAdvertisementPage(),
      binding: NewAdvertisementBinding(),
    ),
    GetPage(
      name: AppRoutes.congratulations,
      page: () => const CongratulationsPage(),
    ),
    GetPage(
      name: AppRoutes.myAdvertisement,
      page: () => const MyAdvertisementPage(),
      binding: MyAdvertisementBinding(),
    ),
    GetPage(
      name: AppRoutes.myProfile,
      page: () => const MyProfilePage(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: AppRoutes.webView,
      page: () {
        WebViewScreen webView = Get.arguments;
        return webView;
      },
    ),
    GetPage(
        name: AppRoutes.photoView,
        page: () {
          PhotoViewerPage photoView = Get.arguments;
          return photoView;
        },
        fullscreenDialog: true),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => const FilterPage(),
      //binding: FilterBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
        name: AppRoutes.notification,
        page: () => const NotificationPage(),
        binding: NotificationBinding(),
    ),
  ];
}

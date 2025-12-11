import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/brand.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';
import '../../../app/data/provider/brand_provider.dart';

class BrandController extends GetxController with AnalyticsMixin {
  final BrandProvider provider;
  BrandController({required this.provider});

  final brandList = <Brand>[].obs;

  @override
  void onInit() {
    //  getBrands();
    super.onInit();

    // Track brand page view
    trackPageView(pageName: 'Brands');
  }

  getBrands() async {
    try {
      final result = await provider.getBrands();
      brandList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }
}

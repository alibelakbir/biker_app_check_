import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/brand_moto.dart';
import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:biker_app/app/modules/brand_details_module/brand_details_page.dart';
import 'package:get/get.dart';

class BrandDetailsController extends GetxController {
  final BrandProvider provider;
  BrandDetailsController({required this.provider});

  final motoList = <BrandMoto>[].obs;

  late BrandDetailsPage page;

  @override
  onInit() {
    page = Get.arguments;
    getBrandMotos();
    super.onInit();
  }

  getBrandMotos() async {
    try {
      final result = await provider.getBrandMotos(page.brand.name);
      motoList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }
}

import 'package:biker_app/app/data/model/brand_moto.dart';

import '../api/api_connect.dart';
import '../model/brand.dart';
import '../../utils/constants.dart';

class BrandProvider {
  BrandProvider();

  Future<List<Brand>> getBrands() async {
    final resp = (await ApiConnect.instance.get(EndPoints.activeMarques))
        .getBody() as List;
    return resp.map((e) => Brand.fromMap(e)).toList();
  }

  Future<List<BrandMoto>> getBrandMotos(brand) async {
    final resp =
        (await ApiConnect.instance.get('${EndPoints.ficheMotMarque}/$brand'))
            .getBody() as List;
    return resp.map((e) => BrandMoto.fromMap(e)).toList();
  }

  Future<List<String>> getBrandsByType(type) async {
    final resp =
        (await ApiConnect.instance.get('${EndPoints.brands}?type=$type'))
            .getBody() as List;
    return resp.map((e) => e.toString()).toList();
  }
}

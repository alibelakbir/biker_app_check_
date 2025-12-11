import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/utils/constants.dart';

class HomeProvider {
  HomeProvider();

  // Get request
  Future<List<Advertisement>> getMotoAcceuil() async {
    final resp = (await ApiConnect.instance.get(EndPoints.motoAcceuil))
        .getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<List<Advertisement>> getMotard() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.motard)).getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<List<Advertisement>> getMoto() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.moto)).getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<List<Advertisement>> getPiece() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.piece)).getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<List<Advertisement>> getPneu() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.pneu)).getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<List<Brand>> getHomeBrands() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.marqueHome)).getBody() as List;
    return resp.map((e) => Brand.fromMap(e)).toList();
  }
}

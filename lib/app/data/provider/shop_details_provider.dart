import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/utils/constants.dart';

class ShopDetailsProvider {
  ShopDetailsProvider();

  Future<Shop> getShop(id) async {
    final resp =
        (await ApiConnect.instance.get('${EndPoints.boutique}/$id')).getBody();
    return Shop.fromMap(resp);
  }

  Future<List<Advertisement>> getShopProducts(id, prefixUrl) async {
    final resp =
        (await ApiConnect.instance.get('$prefixUrl/$id')).getBody() as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }
}

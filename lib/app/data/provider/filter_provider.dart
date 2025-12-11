import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/utils/constants.dart';

class FilterProvider {
  FilterProvider();

  // Get request
 /*  Future<User> getUser() async {
    return User.fromJson(
      (await ApiConnect.instance.get(EndPoints.user)).getBody(),
    );
  } */

  Future<List<String>> getCities() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.cities)).getBody() as List;

    return resp.map((e) => e.toString()).toList();
  }

  Future<List<String>> getCategories(type) async {
    final resp =
        (await ApiConnect.instance.get('${EndPoints.categories}/$type'))
            .getBody() as List;

    return resp.map((e) => e.toString()).toList();
  }
}

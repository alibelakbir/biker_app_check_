import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/model/response/ad_response.dart';
import 'package:biker_app/app/utils/constants.dart';

class ListingMotoProvider {
  ListingMotoProvider();

  Future<AdResponse> getAnnonceMoto(
      {page = 1,
      marque,
      modele,
      prixmin,
      prixmax,
      kilometragemin,
      kilometragemax,
      ville,
      cylindre}) async {
    Map<String, dynamic> queryParams = {};
    if (marque != null && !marque!.contains('TOUTES')) {
      queryParams['marque'] = '$marque';
    }
    if (modele != null && modele.isNotEmpty) {
      queryParams['modele'] = '$modele';
    }
    if (prixmin != null) {
      queryParams['prixmin'] = '$prixmin';
    }
    if (prixmax != null && prixmax < filterMaxPrice) {
      queryParams['prixmax'] = '$prixmax';
    }

    if (kilometragemin != null) {
      queryParams['kilometragemin'] = '$kilometragemin';
    }
    if (kilometragemax != null && kilometragemax < filterMaxKm) {
      queryParams['kilometragemax'] = '$kilometragemax';
    }
    if (ville != null) queryParams['ville'] = '$ville';
    if (cylindre != null) queryParams['cylindre'] = '$cylindre';

    queryParams['page'] = '$page';
    queryParams['limit'] = '${EndPoints.limitData}';

    var uri =
        Uri.parse(EndPoints.annonceMoto).replace(queryParameters: queryParams);
    final resp = (await ApiConnect.instance.get(uri.toString())).getBody();
    return AdResponse.fromMap(resp);
  }

  Future<AdResponse> getAnnonceEquipement(
      {required type, page = 1, category, prixmin, prixmax, ville}) async {
    Map<String, dynamic> queryParams = {};

    if (category != null) queryParams['categorie'] = '$category';
    if (prixmin != null) {
      queryParams['prixmin'] = '$prixmin';
    }
    if (prixmax != null && prixmax < filterMaxPrice) {
      queryParams['prixmax'] = '$prixmax';
    }
    if (ville != null) queryParams['ville'] = '$ville';

    queryParams['type'] = '$type';

    queryParams['page'] = '$page';
    queryParams['limit'] = '${EndPoints.limitData}';

    var uri = Uri.parse(EndPoints.annonceEquipement)
        .replace(queryParameters: queryParams);
    final resp = (await ApiConnect.instance.get(uri.toString())).getBody();
    return AdResponse.fromMap(resp);
  }
}

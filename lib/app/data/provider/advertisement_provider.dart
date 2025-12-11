import 'dart:convert';

import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/api/api_connect_2.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/response/ad_response.dart';
import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdvertisementProvider {
  AdvertisementProvider();

  Future<Advertisement> adDetails(int id, bool isMoto) async {
    final resp =
        (await ApiConnect.instance.get(
          '${isMoto ? EndPoints.motoDetail : EndPoints.equipementDetail}/$id',
        )).getBody();
    return Advertisement.fromMap(resp);
  }

  // Get request
  Future<List<Advertisement>> getMotoSimilaires(id, marque) async {
    final resp =
        (await ApiConnect.instance.get(
              '${EndPoints.motoSimilaires}/$marque/$id',
            )).getBody()
            as List;
    return resp.map((e) => Advertisement.fromMap(e)).toList();
  }

  Future<void> incrementerVuesMoto(id, {bool isMoto = true}) async {
    (await ApiConnect2.instance.post(
      '${isMoto ? EndPoints.incrementerVuesMoto : EndPoints.incrementerVuesEq}/$id',
      jsonEncode({}),
    )).getData();
  }

  Future<void> addEvent(id, category, type) async {
    (await ApiConnect2.instance.post(
      EndPoints.addEvent,
      jsonEncode({"categorie": category, "type": type, "id": id}),
    )).getData();
  }

  Future<Shop> getInfoUtilisateur(id) async {
    return Shop.fromMap(
      (await ApiConnect.instance.get(
        '${EndPoints.infoUtilisateur}/$id',
      )).getBody(),
    );
  }

  Future<AdResponse> mesAnnonce({required type, page = 1}) async {
    Map<String, dynamic> queryParams = {};
    //if (query != null) queryParams['q'] = '$query';
    queryParams['type_equipement'] = '$type';
    queryParams['page'] = '$page';
    queryParams['itemPerPage'] = '${EndPoints.limitData}';

    var uri = Uri.parse(
      EndPoints.mesAnnonceEq,
    ).replace(queryParameters: queryParams);
    final resp = (await ApiConnect2.instance.get(uri.toString())).getData();
    return AdResponse.fromMap(resp);
  }

  Future<AdResponse> mesAnnonceMoto({page = 1}) async {
    Map<String, dynamic> queryParams = {};
    queryParams['page'] = '$page';
    queryParams['itemPerPage'] = '${EndPoints.limitData}';

    var uri = Uri.parse(
      EndPoints.mesAnnonceMoto,
    ).replace(queryParameters: queryParams);
    final resp = (await ApiConnect2.instance.get(uri.toString())).getData();
    return AdResponse.fromMap(resp);
  }

  Future<void> disableAnnonce(int id, bool isMoto) async {
    (await ApiConnect2.instance.put(
      '${isMoto ? EndPoints.desactiverAnnonceMoto : EndPoints.desactiverAnnonce}/$id',
      json.encode({}),
    )).getData();
  }

  Future<bool> userExists(String uid) async {
    final doc =
        await Get.find<FirebaseFirestore>()
            .collection(EndPoints.fUsers) // your collection name
            .doc(uid)
            .get();

    return doc.exists;
  }

  Future<void> reportAd(id, motif, type, {details, email, phone}) async {
    (await ApiConnect2.instance.post(
      EndPoints.report,
      jsonEncode({
        "motif": motif,
        "type_annonce": type,
        "idannonce": id,
        "details": details,
        "contact_email": email,
        "contact_phone": phone,
      }),
    )).getData();
  }
}

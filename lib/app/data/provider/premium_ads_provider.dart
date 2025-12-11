import 'dart:convert';

import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/api/api_connect_2.dart';
import 'package:biker_app/app/data/model/premium_ad.dart';
import 'package:biker_app/app/utils/constants.dart';

class PremiumAdsProvider {
  Future<PremiumAd> getPremiumAd(String page, String emplacement) async {
    final resp =
        (await ApiConnect.instance.get(
          '${EndPoints.premiumads}?device=mobile&page=$page&emplacement=$emplacement&limit=1',
        )).getBody();
    return PremiumAd.fromMap(resp);
  }

  Future<List<PremiumAd>> getPremiumAds() async {
    final resp =
        (await ApiConnect.instance.get(
              '${EndPoints.premiumads}?device=mobile&page=listing&emplacement=card&limit=10',
            )).getBody()
            as List;
    return resp.map((e) => PremiumAd.fromMap(e)).toList();
  }

  Future<void> reachPremiumAd(id) async {
    (await ApiConnect2.instance.post(
      '${EndPoints.premiumads}/$id/reach',
      jsonEncode({}),
    )).getData();
  }

  Future<void> clickPremiumAd(id) async {
    (await ApiConnect2.instance.post(
      '${EndPoints.premiumads}/$id/click',
      jsonEncode({}),
    )).getData();
  }
}

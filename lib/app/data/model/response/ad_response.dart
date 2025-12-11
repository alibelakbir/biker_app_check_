// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/utils/extensions.dart';

class AdResponse {
  List<Advertisement> annonces;
  int page;
  int totalPages;
  AdResponse({
    this.annonces = const [],
    required this.page,
    required this.totalPages,
  });

  factory AdResponse.fromMap(Map<String, dynamic> map) {
    return AdResponse(
      annonces: map['annonces'] != null
          ? List<Advertisement>.from(
              (map['annonces'] as List<dynamic>).map<Advertisement>(
                (x) => Advertisement.fromMap(x as Map<String, dynamic>),
              ),
            ).shuffledByHour()
          : List<Advertisement>.from(
              (map['data'] as List<dynamic>).map<Advertisement>(
                (x) => Advertisement.fromMap(x as Map<String, dynamic>),
              ),
            ),
      page:
          map['page'] != null ? map['page'] as int : map['currentPage'] as int,
      totalPages: map['totalPages'] as int,
    );
  }

  factory AdResponse.fromJson(String source) =>
      AdResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

import 'package:biker_app/app/utils/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  int id;
  String name;
  String logo;
  bool active;
  Brand({
    required this.id,
    required this.name,
    required this.logo,
    this.active = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'active': active,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['idmarque'] as int,
      name: map['nom_marque'] as String,
      logo: EndPoints.brandMediaUrl(map['logo'] as String),
      active: map['active'] != null ? map['active'] as int == 1 : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

import 'package:biker_app/app/utils/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String nom;
  String prenom;
  String email;
  String role;
  String? telephone;
  String? ville;
  String? logo;
  String? adresse;
  String? description;
  String? siteWeb;
  String? uid;
  String? compName;
  AppUser({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.role,
    this.telephone,
    this.ville,
    this.logo,
    this.adresse,
    this.description,
    this.siteWeb,
    this.uid,
    this.compName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'role': role,
      'telephone': telephone,
      'ville': ville,
      'logo': logo,
      'adresse': adresse,
      'description': description,
      'site_web': siteWeb,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      telephone: map['telephone'] != null ? map['telephone'] as String : null,
      ville: map['ville'] != null ? map['ville'] as String : null,
      logo:
          map['logo'] != null
              ? EndPoints.mediaUrl(map['logo'] as String)
              : null,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      siteWeb: map['site_web'] != null ? map['site_web'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      compName:
          map['nom_entreprise'] != null
              ? map['nom_entreprise'] as String
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}

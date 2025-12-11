import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Shop {
  int idutilisateur;
  String? nomEntreprise;
  String role;
  String? adresse;
  String ville;
  String telephone;
  String? description;
  String? logo;
  String? siteWeb;
  String uid;
  Shop({
    required this.idutilisateur,
    required this.nomEntreprise,
    required this.role,
    required this.adresse,
    required this.ville,
    required this.telephone,
    this.description,
    required this.logo,
    this.siteWeb,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idutilisateur': idutilisateur,
      'nom_entreprise': nomEntreprise,
      'role': role,
      'adresse': adresse,
      'ville': ville,
      'telephone': telephone,
      'description': description,
      'logo': logo,
      'siteWeb': siteWeb,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      idutilisateur: map['idutilisateur'] as int,
      nomEntreprise: map['nom_entreprise'] != null
          ? map['nom_entreprise'] as String
          : null,
      role: map['role'] as String,
      adresse: map['adresse'] != null ? map['adresse'] as String : null,
      ville: map['ville'] as String,
      telephone: map['telephone'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      siteWeb: map['siteWeb'] != null ? map['siteWeb'] as String : null,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);
}

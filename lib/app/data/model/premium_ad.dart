import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PremiumAd {
  int idpremiumads;
  String imageUrl;
  String redirectUrl;
  String titre;
  String texte;
  String device;
  List<String> pageCible;
  String emplacement;
  String nomEntreprise;
  String logo;
  PremiumAd({
    required this.idpremiumads,
    required this.imageUrl,
    required this.redirectUrl,
    required this.titre,
    required this.texte,
    required this.device,
    required this.pageCible,
    required this.emplacement,
    required this.nomEntreprise,
    required this.logo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idpremiumads': idpremiumads,
      'imageUrl': imageUrl,
      'redirectUrl': redirectUrl,
      'titre': titre,
      'texte': texte,
      'device': device,
      'pageCible': pageCible,
      'emplacement': emplacement,
      'nomEntreprise': nomEntreprise,
      'logo': logo,
    };
  }

  factory PremiumAd.fromMap(Map<String, dynamic> map) {
    return PremiumAd(
      idpremiumads: map['idpremiumads'] as int,
      imageUrl: map['image_url'] as String,
      redirectUrl: map['redirect_url'] as String,
      titre: map['titre'] as String,
      texte: map['texte'] as String,
      device: map['device'] as String,
      pageCible: List<String>.from((map['page_cible'] ?? [])),
      emplacement: map['emplacement'] as String,
      nomEntreprise: map['nom_entreprise'] as String,
      logo: map['logo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PremiumAd.fromJson(String source) =>
      PremiumAd.fromMap(json.decode(source) as Map<String, dynamic>);
}

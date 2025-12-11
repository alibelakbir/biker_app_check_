import 'dart:convert';

import 'package:biker_app/app/utils/extensions.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Advertisement {
  int id;
  int idutilisateur;
  String? categorie;
  String marque;
  String? model;
  String? moteur;
  int? anneemodele;
  int? anneecirculation;
  String? garantie;
  String dateajout;
  String? motorisation;
  String? cylindre;
  int? kilometrage;
  int? chassis;
  int? premieremain;
  String? origine;
  String etat;
  String etatannonce;
  String titre;
  String description;
  num? prix;
  String ville;
  String telephone;
  String nomvendeur;
  List<String?> medias;
  //String vendu;
  int? premium;
  int? nbr_vue;
  int? petite_cylindre;
  String role;
  int vendu;
  String? type;
  String? dimensions;
  Advertisement({
    required this.id,
    required this.idutilisateur,
    this.categorie,
    required this.marque,
    this.model,
    this.moteur,
    this.anneemodele,
    this.anneecirculation,
    this.garantie,
    required this.dateajout,
    this.motorisation,
    this.cylindre,
    this.kilometrage,
    this.chassis,
    this.premieremain,
    this.origine,
    required this.etat,
    required this.etatannonce,
    required this.titre,
    required this.description,
    this.prix,
    required this.ville,
    required this.telephone,
    required this.nomvendeur,
    required this.medias,
    //required this.vendu,
    this.premium,
    this.nbr_vue,
    this.petite_cylindre,
    required this.role,
    required this.vendu,
    this.type,
    this.dimensions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idutilisateur': idutilisateur,
      'categorie': categorie,
      'marque': marque,
      'model': model,
      'moteur': moteur,
      'anneemodele': anneemodele,
      'anneecirculation': anneecirculation,
      'garantie': garantie,
      'dateajout': dateajout,
      'motorisation': motorisation,
      'cylindre': cylindre,
      'kilometrage': kilometrage,
      'chassis': chassis,
      'premieremain': premieremain,
      'origine': origine,
      'etat': etat,
      'titre': titre,
      'description': description,
      'prix': prix,
      'ville': ville,
      'telephone': telephone,
      'nomvendeur': nomvendeur,
      'premium': premium,
      'nbr_vue': nbr_vue,
      'petite_cylindre': petite_cylindre,
      'role': role,
      'vendu': vendu,
      'type': type,
      'dimensions': dimensions,
    };
  }

  factory Advertisement.fromMap(Map<String, dynamic> map) {
    return Advertisement(
      id:
          map['idannonce_moto'] != null
              ? map['idannonce_moto'] as int
              : map['idfiche_moto'] != null
              ? map['idfiche_moto'] as int
              : map['idannonce_equipement'] as int,
      idutilisateur: map['idutilisateur'] as int,
      categorie: map['categorie'] != null ? map['categorie'] as String : null,
      marque: map['marque'] as String,
      model: map['model'] != null ? map['model'] as String : null,
      moteur: map['moteur'] != null ? map['moteur'] as String : null,
      anneemodele:
          map['anneemodele'] != null ? map['anneemodele'] as int : null,
      anneecirculation:
          map['anneecirculation'] != null
              ? map['anneecirculation'] as int
              : null,
      garantie: map['garantie'] != null ? map['garantie'] as String : null,
      dateajout: map['dateajout'] as String,
      motorisation:
          map['motorisation'] != null ? map['motorisation'] as String : null,
      cylindre: map['cylindre'] != null ? map['cylindre'] as String : null,
      kilometrage:
          map['kilometrage'] != null ? map['kilometrage'] as int : null,
      chassis: map['chassis'] != null ? map['chassis'] as int : null,
      premieremain:
          map['premieremain'] != null ? map['premieremain'] as int : null,
      origine: map['origine'] != null ? map['origine'] as String : null,
      etat: map['etat'] as String,
      etatannonce: map['etatannonce'] as String,
      titre: map['titre'] as String,
      description: map['description'] as String,
      prix: map['prix'] != null ? map['prix'] as num : null,
      ville: map['ville'] as String,
      telephone: map['telephone'] as String,
      nomvendeur: map['nomvendeur'] as String,
      medias: List.generate(6, (index) => map['photo${index + 1}']),
      //vendu: map['vendu'] as String,
      premium: map['premium'] != null ? map['premium'] as int : null,
      nbr_vue: map['nbr_vue'] != null ? map['nbr_vue'] as int : null,
      petite_cylindre:
          map['petite_cylindre'] != null ? map['petite_cylindre'] as int : null,
      role: map['role'] != null ? map['role'] as String : 'particulier',
      vendu:
          map['vendu'] != null && map['vendu'] is int ? map['vendu'] as int : 0,
      type: map['type'] != null ? map['type'] as String : null,
      dimensions:
          map['dimensions'] != null ? map['dimensions'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advertisement.fromJson(String source) =>
      Advertisement.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMapAd(bool isMoto, String category) {
    return <String, dynamic>{
      'id': id,
      'title': model,
      'name': marque,
      'type': isMoto ? 'moto' : 'equipement',
      'photo': medias.withoutNullsOrEmpty().first,
      'category': category,
    };
  }

  Advertisement copyWith({
    int? id,
    int? idutilisateur,
    String? categorie,
    String? marque,
    String? model,
    String? moteur,
    int? anneemodele,
    int? anneecirculation,
    String? garantie,
    String? dateajout,
    String? motorisation,
    String? cylindre,
    int? kilometrage,
    int? chassis,
    int? premieremain,
    String? origine,
    String? etat,
    String? etatannonce,
    String? titre,
    String? description,
    num? prix,
    String? ville,
    String? telephone,
    String? nomvendeur,
    List<String?>? medias,
    int? premium,
    int? nbr_vue,
    int? petite_cylindre,
    String? role,
    int? vendu,
    String? type,
    String? dimensions,
  }) {
    return Advertisement(
      id: id ?? this.id,
      idutilisateur: idutilisateur ?? this.idutilisateur,
      categorie: categorie ?? this.categorie,
      marque: marque ?? this.marque,
      model: model ?? this.model,
      moteur: moteur ?? this.moteur,
      anneemodele: anneemodele ?? this.anneemodele,
      anneecirculation: anneecirculation ?? this.anneecirculation,
      garantie: garantie ?? this.garantie,
      dateajout: dateajout ?? this.dateajout,
      motorisation: motorisation ?? this.motorisation,
      cylindre: cylindre ?? this.cylindre,
      kilometrage: kilometrage ?? this.kilometrage,
      chassis: chassis ?? this.chassis,
      premieremain: premieremain ?? this.premieremain,
      origine: origine ?? this.origine,
      etat: etat ?? this.etat,
      etatannonce: etatannonce ?? this.etatannonce,
      titre: titre ?? this.titre,
      description: description ?? this.description,
      prix: prix ?? this.prix,
      ville: ville ?? this.ville,
      telephone: telephone ?? this.telephone,
      nomvendeur: nomvendeur ?? this.nomvendeur,
      medias: medias ?? this.medias,
      premium: premium ?? this.premium,
      nbr_vue: nbr_vue ?? this.nbr_vue,
      petite_cylindre: petite_cylindre ?? this.petite_cylindre,
      role: role ?? this.role,
      vendu: vendu ?? this.vendu,
      type: type ?? this.type,
      dimensions: dimensions ?? this.dimensions,
    );
  }
}

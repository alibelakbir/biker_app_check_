import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BrandMoto {
  int id;
  String marque;
  String? modele;
  String? moteur;
  String? anneemodele;
  num? prix;
  num? prixpromotion;
  String reservoir;
  String embrayage;
  String boiteavitesse;
  String transmissionsecondaire;
  String alimentation;
  int cylindree;
  String puissance;
  String couplemax;
  String alesage;
  String chassis;
  String poidsvide;
  String poidsaveccharge;
  String longueur;
  String largeur;
  String hauteur;
  String hauteurselle;
  String abs;
  String freinavant;
  String freinarriere;
  String pneumatiqueavant;
  String pneumatiquearriere;
  String suspensionavant;
  String suspensionarriere;
  List<String> medias;
  String consommationmoyenne;
  String vitessemaximum;
  BrandMoto({
    required this.id,
    required this.marque,
    this.modele,
    this.moteur,
    this.anneemodele,
    this.prix,
    this.prixpromotion,
    required this.reservoir,
    required this.embrayage,
    required this.boiteavitesse,
    required this.transmissionsecondaire,
    required this.alimentation,
    required this.cylindree,
    required this.puissance,
    required this.couplemax,
    required this.alesage,
    required this.chassis,
    required this.poidsvide,
    required this.poidsaveccharge,
    required this.longueur,
    required this.largeur,
    required this.hauteur,
    required this.hauteurselle,
    required this.abs,
    required this.freinavant,
    required this.freinarriere,
    required this.pneumatiqueavant,
    required this.pneumatiquearriere,
    required this.suspensionavant,
    required this.suspensionarriere,
    required this.medias,
    required this.consommationmoyenne,
    required this.vitessemaximum,
  });

  factory BrandMoto.fromMap(Map<String, dynamic> map) {
    return BrandMoto(
      id: map['idfiche_moto'] as int,
      marque: map['marque'] as String,
      modele: map['modele'] != null ? map['modele'] as String : null,
      moteur: map['moteur'] != null ? map['moteur'] as String : null,
      anneemodele:
          map['annemodele'] != null ? map['annemodele'] as String : null,
      prix: map['prix'] != null ? map['prix'] as num : null,
      prixpromotion:
          map['prixpromotion'] != null ? map['prixpromotion'] as num : null,
      reservoir: map['reservoir'] != null ? map['reservoir'] as String : '',
      embrayage: map['embrayage'] != null ? map['embrayage'] as String : '',
      boiteavitesse:
          map['boiteavitesse'] != null ? map['boiteavitesse'] as String : '',
      transmissionsecondaire: map['transmissionsecondaire'] != null
          ? map['transmissionsecondaire'] as String
          : '',
      alimentation:
          map['alimentation'] != null ? map['alimentation'] as String : '',
      cylindree: map['cylindree'] != null ? map['cylindree'] as int : 0,
      puissance: map['puissance'] != null ? map['puissance'] as String : '',
      couplemax: map['couplemax'] != null ? map['couplemax'] as String : '',
      alesage: map['alesage'] as String,
      chassis: map['chassis'] != null ? map['chassis'] as String : '',
      poidsvide: map['poidsvide'] != null ? map['poidsvide'] as String : '',
      poidsaveccharge: map['poidsaveccharge'] != null
          ? map['poidsaveccharge'] as String
          : '',
      longueur: map['longueur'] != null ? map['longueur'] as String : '',
      largeur: map['largeur'] != null ? map['largeur'] as String : '',
      hauteur: map['hauteur'] != null ? map['hauteur'] as String : '',
      hauteurselle:
          map['hauteurselle'] != null ? map['hauteurselle'] as String : '',
      abs: map['abs'] != null ? map['abs'] as String : '',
      freinavant: map['freinavant'] != null ? map['freinavant'] as String : '',
      freinarriere:
          map['freinarriere'] != null ? map['freinarriere'] as String : '',
      pneumatiqueavant: map['pneumatiqueavant'] != null
          ? map['pneumatiqueavant'] as String
          : '',
      pneumatiquearriere: map['pneumatiquearriere'] != null
          ? map['pneumatiquearriere'] as String
          : '',
      suspensionavant: map['suspensionavant'] != null
          ? map['suspensionavant'] as String
          : '',
      suspensionarriere: map['suspensionarriere'] != null
          ? map['suspensionarriere'] as String
          : '',
      medias: List.generate(10, (index) => map['photo${index + 1}'])
          .whereType<String>()
          .where((media) => media.trim().isNotEmpty)
          .toList(),
      consommationmoyenne: map['consommationmoyenne'] != null
          ? map['consommationmoyenne'] as String
          : '',
      vitessemaximum:
          map['vitessemaximum'] != null ? map['vitessemaximum'] as String : '',
    );
  }

  factory BrandMoto.fromJson(String source) =>
      BrandMoto.fromMap(json.decode(source) as Map<String, dynamic>);
}

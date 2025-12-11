import 'dart:developer';

import 'package:biker_app/app/utils/local_data.dart';

const String CACHED_TOKEN = 'CACHED_TOKEN';
const String CACHED_USER = 'CACHED_USER';
const String CACHED_LAST_SEEN_NOTIFICATION = 'CACHED_LAST_SEEN_NOTIFICATION';
const String CACHED_GUEST_UID = 'CACHED_GUEST_UID';

class EndPoints {
  const EndPoints._();

  static const androidStoreUrl =
      'https://play.google.com/store/apps/details?id=com.bikerapp.ma';
  static const iosStoreUrl =
      'https://apps.apple.com/ma/app/biker-ma/id6748947273';

  static String baseUrl = 'https://biker.ma/api/v1/';
  static const String motoAcceuil = "moto/annonce-accueil";
  static const String moto = "equipement/annonce-accueil/moto";
  static const String motard = "equipement/annonce-accueil/motard";
  static const String piece = "equipement/annonce-accueil/piece";
  static const String pneu = "equipement/annonce-accueil/pneu";
  static const String marqueHome = "marque/home";
  static const String motoSimilaires = "moto/similaires";
  static const String incrementerVuesMoto = "moto/incrementer-vues";
  static const String incrementerVuesEq = "equipement/incrementer-vues";
  static const String activeMarques = "marque/active";
  static const String ficheMotMarque = "fichemoto/marque";
  static const String annonceMoto = "moto/annonce";
  static const String annonceEquipement = "equipement/annonce";
  static const String boutique = "boutique";
  static const String infoUtilisateur = "utilisateur/info";
  static const String user = 'utilisateur/user-by-token';
  static const String addUser = 'utilisateur/adduser';
  static const String phoneExist = 'utilisateur/telephone-existe';
  static const String emailExist = 'utilisateur/existe';
  static const String cities = 'ville/villes';
  static const String brands = "marque";
  static const String annonce = "moto/utilisateur/annonce";
  static const String annonceEq = "equipement/annonce";
  static const String mesAnnonceMoto = "moto/utilisateur/annonces";
  static const String mesAnnonceEq = "equipement/utilisateur/annonces";
  static const String categories = "equipement/categories";
  static const String desactiverAnnonce = "equipement/annonce/desactiver";
  static const String desactiverAnnonceMoto =
      "moto/utilisateur/annonce/desactiver";
  static const String updateUser = "utilisateur/update-user";
  static const String addEvent = "evenement/addevent";
  static const String motoDetail = "moto/detail";
  static const String equipementDetail = "equipement/detail";
  static const String updateFcmToken = "utilisateur/update-fcm-token";
  static const String notification = "notification";
  static const String notificationCount = "notification/alerts";
  static const String report = "signalement";
  static const String premiumads = "premiumads";

  static const String fUsers = "users_dev";
  static const String fChatRooms = "chat_rooms_dev";

  static const String conditionPolitique =
      "https://www.biker.ma/pages/condition-politique";
  static const String conditionVente =
      "https://www.biker.ma/pages/conditions-generales-de-vente";

  static const String deleteAccount =
      "https://www.biker.ma/compte/supprimercompte";
  static const String contactPage = "https://biker.ma/pages/contact";

  static String brandMediaUrl(logo) =>
      "https://biker.ma/assets/img/brands-logo/$logo";

  static String? brandMotoMediaUrl(name) =>
      name != null ? 'https://biker.ma/uploads/fiche-technique/$name' : null;

  static String? mediaUrl(name) =>
      name != null
          ? name.contains('http')
              ? name
              : 'https://biker.ma/uploads/$name'
          : null;

  static const Duration timeout = Duration(seconds: 30);

  static const String token = 'authToken';

  static const int limitData = 20;

  static Map<String, String> header =
      LocalData.accessToken == null
          ? {'Accept': 'application/json'}
          : {
            'Authorization': "Bearer ${LocalData.accessToken}",
            'Accept': 'application/json',
          };
  static get lastHeader => header;

  static setHeader({String? token}) {
    log('${LocalData.accessToken}');
    header = {
      'Authorization': "Bearer ${token ?? LocalData.accessToken}",
      'Accept': 'application/json',
    };
  }
}

var categoryList = const [
  {"id": "annonce-moto", "name": "Moto", "imageName": "moto.png"},
  {
    "id": "annonce-equipement",
    "name": "Éq. Motard",
    "imageName": "casque.png",
    "type": "motard",
  },
  {
    "id": "annonce-equipement",
    "name": "Éq. Moto",
    "imageName": "key.png",
    "type": "moto",
  },
  {
    "id": "annonce-equipement",
    "name": "Pneu",
    "imageName": "pneu.png",
    "type": "pneu",
  },
  {
    "id": "annonce-equipement",
    "name": "Pc. Rechange",
    "imageName": "piece_rechange.png",
    "type": "piece",
  },
  {
    "id": "annonce-equipement",
    "name": "Huile",
    "imageName": "oil.png",
    "type": "oil",
  },
];

var categoryAdList = ["Sportive", "Electrique"];
var motorisationList = ["Essence", "Electrique", "2T", "4T"];

var origineList = [
  "ww Au Maroc",
  "dédouanée",
  "importée neuve",
  "pas encore dédouanée",
];

var etatList = ["neuf", "très bon", "bon", "correcte", "endommagé"];

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

var mesAnnonceCategoryList = const [
  {"id": "annonce-moto", "name": "Moto", "imageName": "moto.png"},
  {"id": "annonce-equipement", "name": "Éq. Motard", "imageName": "casque.png"},
  {"id": "annonce-equipement", "name": "Éq. Moto", "imageName": "key.png"},
  {"id": "annonce-equipement", "name": "Pneu", "imageName": "pneu.png"},
  {
    "id": "annonce-equipement",
    "name": "Pc. Rechange",
    "imageName": "piece_rechange.png",
  },
  {"id": "annonce-equipement", "name": "Huil", "imageName": "oil.png"},
];

final reportMotifList = const [
  {
    "id": 1,
    "title": "Annonce en double",
    "description":
        "Cette annonce apparaît plusieurs fois (même titre, photos, vendeur…).",
  },
  {
    "id": 2,
    "title": "Annonce frauduleuse / arnaque",
    "description":
        "Paiement à l’avance, incohérences, identité douteuse, liens suspects, etc.",
  },
  {
    "id": 3,
    "title": "Prix incorrect / anormal",
    "description":
        "Prix manifestement erroné (0 DH, trop bas) ou ne correspondant pas au contenu.",
  },
  {
    "id": 4,
    "title": "Informations trompeuses / inexactes",
    "description":
        "Photos/infos ne correspondent pas, kilométrage/année faux, description mensongère.",
  },
  {
    "id": 5,
    "title": "Coordonnées invalides / injoignable",
    "description":
        "Numéro/email invalide ou vendeur injoignable à plusieurs reprises.",
  },
  {
    "id": 6,
    "title": "Autre (préciser)",
    "description": "Expliquez brièvement le problème dans la zone “Détails”.",
  },
];

const double filterMaxPrice = 200000;
const double filterMaxKm = 50000;

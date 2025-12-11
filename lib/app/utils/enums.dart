enum CategoryEnum {
  moto('moto'),
  equipementMoto('annonce-equipemen'),
  news('news'),
  product('product'),
  user('user');

  const CategoryEnum(this.value);
  final String value;
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }

enum PickerType {
  image('image'),
  multiImage('multiImage'),
  media('media'),
  multipleMedia('multipleMedia'),
  video('video');

  const PickerType(this.value);
  final String value;
}

enum CylindreEnum {
  moins50('Moins de 50 cm3'),
  de50a150('De 50 à 150 cm3'),
  de150a500('De 150 à 500 cm3'),
  de500a1000('De 500 à 1000 cm3'),
  plus1000('1000 cm3 et plus');

  const CylindreEnum(this.value);
  final String value;
}

enum PremiumAdType { banner, card, icon }

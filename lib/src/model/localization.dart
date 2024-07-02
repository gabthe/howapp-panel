// ignore_for_file: public_member_api_docs, sort_constructors_first
class Localization {
  String numberName;
  String adressName;
  String neighborhoodName;
  String cityName;
  String federativeUnitLongeName;
  String federativeUnitShortName;
  String countryShortName;
  String countryLongName;
  String postalCode;
  String fullAddress;
  double lat;
  double lng;
  Localization({
    required this.numberName,
    required this.adressName,
    required this.neighborhoodName,
    required this.cityName,
    required this.federativeUnitLongeName,
    required this.federativeUnitShortName,
    required this.countryShortName,
    required this.countryLongName,
    required this.postalCode,
    required this.fullAddress,
    required this.lat,
    required this.lng,
  });

  factory Localization.fromMap(Map<String, dynamic> map) {
    return Localization(
      adressName: map['adressName'],
      cityName: map['cityName'],
      countryLongName: map['countryLongName'],
      countryShortName: map['countryShortName'],
      federativeUnitLongeName: map['federativeUnitLongeName'],
      federativeUnitShortName: map['federativeUnitShortName'],
      fullAddress: map['fullAddress'],
      lat: map['lat'],
      lng: map['lng'],
      neighborhoodName: map['neighborhoodName'],
      numberName: map['numberName'],
      postalCode: map['postalCode'],
    );
  }
}

import 'dart:convert';

import '../../utils/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingModel {
  String url;
  String androidVersion;
  String iosVersion;
  bool forceUpdate;
  bool maintenanceMode;
  SettingModel({
    this.url =
        'https://allomatch-api-dev.agreeablemoss-40dc21a2.spaincentral.azurecontainerapps.io/',
    this.androidVersion = '0.0.1',
    this.iosVersion = '0.0.1',
    this.forceUpdate = false,
    this.maintenanceMode = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'androidVersion': androidVersion,
      'iosVersion': iosVersion,
      'forceUpdate': forceUpdate,
      'maintenanceMode': maintenanceMode,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      url: map['url'] != null ? map['url'] as String : EndPoints.baseUrl,
      androidVersion: map['androidVersion'] != null
          ? map['androidVersion'] as String
          : '0.0.1',
      iosVersion:
          map['iosVersion'] != null ? map['iosVersion'] as String : '0.0.1',
      forceUpdate:
          map['forceUpdate'] != null ? map['forceUpdate'] as bool : false,
      maintenanceMode: map['maintenanceMode'] != null
          ? map['maintenanceMode'] as bool
          : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

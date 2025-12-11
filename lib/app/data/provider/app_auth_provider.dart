import 'dart:convert';
import 'dart:developer';

import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/api/api_connect_2.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/app_user.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class AppAuthProvider {
  AppAuthProvider();

  Future<List<String>> getCities() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.cities)).getBody() as List;

    return resp.map((e) => e.toString()).toList();
  }

  Future<AppUser> getUser({String? token}) async {
    return AppUser.fromMap(
      (await ApiConnect2.instance.post(
        Uri.parse(EndPoints.user).toString(),
        jsonEncode({}),
        headers: token != null ? EndPoints.setHeader(token: token) : null,
      )).getData(),
    );
  }

  Future<void> addUser(user) async {
    (await ApiConnect2.instance.post(
      EndPoints.addUser,
      jsonEncode(user),
    )).getData();
  }

  Future<bool> emailExist(email) async {
    return (await ApiConnect.instance.get(
      '${EndPoints.emailExist}?email=$email',
    )).getBody();
  }

  Future<bool> phoneExist(phone) async {
    Map<String, dynamic> queryParams = {};
    queryParams['telephone'] = '$phone';
    var uri = Uri.parse(
      EndPoints.phoneExist,
    ).replace(queryParameters: queryParams);
    return (await ApiConnect.instance.get(uri.toString())).getBody();
  }

  Future<void> updateUser(Map<String, dynamic> user, {String? logo}) async {
    if (logo != null) {
      final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.updateUser}');
      var request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(EndPoints.lastHeader);
      final fields = user.map((key, value) => MapEntry(key, value.toString()));
      request.fields.addAll(fields);
      request.files.add(
        await http.MultipartFile.fromPath(
          'logo',
          logo,
          filename: basename(logo),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          log(responseBody);
        } else {
          log(await response.stream.bytesToString());
          throw ServerResError('Failed with status: ${response.statusCode}');
        }
      } catch (e) {
        log('Error: $e');
        throw UnknownError();
      }
    } else {
      (await ApiConnect2.instance.put(
        EndPoints.updateUser,
        jsonEncode(user),
      )).getData();
    }
  }

  Future<void> updateFcmToken(String fcm, {String? guestId}) async {
    (await ApiConnect2.instance.post(
      EndPoints.updateFcmToken,
      jsonEncode({'fcmtoken': fcm, 'guestId': guestId}),
    )).getData();
  }
}

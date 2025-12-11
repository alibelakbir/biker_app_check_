import 'dart:developer';

import 'package:biker_app/app/data/api/api_connect.dart';

import '../api/api_error.dart';
import '../model/advertisement.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class NewAdvertisementProvider {
  NewAdvertisementProvider();

  Future<void> addAnnonce(
      List<String> images, Advertisement ad, int type) async {
    log(ad.toJson());
    String url = 'https://www.biker.ma/api/v1/';
    late Uri uri;
    if (type == 0) {
      uri = Uri.parse(url + EndPoints.annonce);
    } else {
      uri = Uri.parse(url + EndPoints.annonceEq);
    }

    var request = http.MultipartRequest('POST', uri);

    // Set headers
    request.headers.addAll(EndPoints.lastHeader);

    final fields =
        ad.toMap().map((key, value) => MapEntry(key, value.toString()));

    // Add form fields
    request.fields.addAll(fields);

    // Add image file
    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'photo${i + 1}', images[i],
          filename: basename(images[i]),
          contentType: MediaType('image', 'jpeg')));
    }

    // Send request
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
      } else {
        print(await response.stream.bytesToString());
        throw ServerResError('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw UnknownError();
    }
  }

  Future<void> editAnnonce(
      int id, List<String> images, Advertisement ad, int type,
      {List deletedImages = const []}) async {
    log(ad.toJson());
    log(images.toString());

    String url = 'https://www.biker.ma/api/v1/';
    late Uri uri;
    if (type == 0) {
      uri = Uri.parse('$url${EndPoints.annonce}/$id');
    } else {
      uri = Uri.parse('$url${EndPoints.annonceEq}/$id');
    }

    var request = http.MultipartRequest('PUT', uri);

    // Set headers
    request.headers.addAll(EndPoints.lastHeader);

    final fields =
        ad.toMap().map((key, value) => MapEntry(key, value.toString()));

    for (var d in deletedImages) {
      fields.addAll(d);
    }

    // Add form fields
    request.fields.addAll(fields);

    // Add image file
    for (int i = 0; i < images.length; i++) {
      if (images[i].isNotEmpty && !images[i].contains('http')) {
        request.files.add(await http.MultipartFile.fromPath(
            'photo${i + 1}', images[i],
            filename: basename(images[i]),
            contentType: MediaType('image', 'jpeg')));
      }
    }

    // Send request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
      } else {
        print(await response.stream.bytesToString());
        throw ServerResError('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw UnknownError();
    }
  }

  Future<List<String>> getCities() async {
    final resp =
        (await ApiConnect.instance.get(EndPoints.cities)).getBody() as List;

    return resp.map((e) => e.toString()).toList();
  }

  Future<List<String>> getCategories(type) async {
    final resp =
        (await ApiConnect.instance.get('${EndPoints.categories}/$type'))
            .getBody() as List;

    return resp.map((e) => e.toString()).toList();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:biker_app/app/utils/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConnect extends GetConnect {
  static final ApiConnect instance = ApiConnect._();
  dynamic _reqBody;

  ApiConnect._() {
    baseUrl = EndPoints.baseUrl;
    logPrint = print;
    timeout = EndPoints.timeout;

    httpClient.addRequestModifier<dynamic>((request) {
      logPrint('************** Request **************');
      _printKV('uri', request.url);
      _printKV('method', request.method);
      _printKV('followRedirects', request.followRedirects);
      logPrint('headers:');
      request.headers.forEach((key, v) => _printKV(' $key', v));
      logPrint('data:');
      if (_reqBody is Map) {
        _reqBody?.forEach((key, v) => _printKV(' $key', v));
      } else {
        _printAll(_reqBody.toString());
      }
      logPrint('*************************************');
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      logPrint('************** Response **************');
      _printKV('uri', response.request!.url);
      _printKV('statusCode', response.statusCode!);
      if (response.headers != null) {
        logPrint('headers:');
        response.headers?.forEach((key, v) => _printKV(' $key', v));
      }
      logPrint('Response Text:');
      _printAll(response.bodyString);
      logPrint('*************************************');
      return response;
    });
  }

  Future<Response<T>> handleRequest<T>(
      Future<Response<T>> Function() requestFunction) async {
    await checkTokenBeforeRequest();
    Response<T> response = await requestFunction();
    return response;
  }

  Future<void> checkTokenBeforeRequest() async {
    final token = LocalData.accessToken;
    if (token == null) return;

    try {
      final payload = decodeJwt(token);
      var exp = payload['exp'];

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final now = DateTime.now();
      log('Expired date: $expiryDate');

      if (now.isAfter(expiryDate.subtract(Duration(minutes: 10)))) {
        log('Expired token');

        // Expired or about to expire
        await _refreshToken();
      }
    } catch (e) {
      // If token is invalid or cannot decode, optionally refresh
      await _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    try {
      final user = Get.find<FirebaseAuth>().currentUser;
      final idToken = await user?.getIdToken();
      log('New token $idToken');
      if (idToken != null) {
        var sharedPrefs = Get.find<SharedPreferences>();
        await sharedPrefs.setString(CACHED_TOKEN, idToken);
        LocalData.setAccessToken(idToken);
        EndPoints.setHeader(token: idToken);
      }
    } catch (e) {
      throw Exception('Refresh token error: $e');
    }
  }

  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    final payload = base64Url.normalize(parts[1]);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(payload)));

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  late void Function(Object object) logPrint;

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();
    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = query;
    return handleRequest(() => httpClient.get<T>(
          url,
          headers: headers ?? EndPoints.lastHeader,
          contentType: contentType,
          query: query,
          decoder: decoder,
        )..whenComplete(() => _reqBody = null));
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();

    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = query;
    return httpClient.delete<T>(
      url,
      headers: headers ?? EndPoints.lastHeader,
      contentType: contentType,
      query: query,
      decoder: decoder,
    )..whenComplete(() => _reqBody = null);
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();

    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();
    try {
      _reqBody = body;
    } catch (e) {
      // print(e.toString());
    }

    return httpClient.post<T>(
      url,
      body: body,
      headers: headers ?? EndPoints.lastHeader,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    )..whenComplete(() => _reqBody = null);
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();

    // _headers["Authorization"] = "Bearer " + HiveAdapter.getAccessToken();

    _reqBody = body;

    return httpClient.put<T>(
      url,
      body: body,
      headers: headers ?? EndPoints.lastHeader,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    )..whenComplete(() => _reqBody = null);
  }

  void _printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void _checkIfDisposed() {
    if (isDisposed) {
      throw 'Can not emit events to disposed clients';
    }
  }
}

extension ResErr<T> on Response<T> {
  T getBody() {
    if (status.connectionError) {
      throw NoConnectionError();
    }

    if (status.isUnauthorized) {
      throw UnauthorizedError();
    }

    if (status.code == HttpStatus.badRequest) {
      final res = jsonDecode(bodyString!);
      throw ServerResError(res.toString());
    }

    if (status.code == HttpStatus.requestTimeout) {
      throw TimeoutError();
    }

    if (!status.isOk) {
      throw UnknownError();
    }

    try {
      final res = jsonDecode(bodyString!);

      if (res is Map && res['valid'] != null && !res['valid']) {
        throw ServerResError(res['message']);
      }

      return body!;
    } on TimeoutException catch (_) {
      throw TimeoutError();
    } catch (_) {
      throw UnknownError();
    }
  }
}

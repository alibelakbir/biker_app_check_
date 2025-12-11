import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';

abstract class ApiErrors implements Exception {
  final String message = "";
  ApiErrors({String? name}) {
    log(message, name: name ?? "");
  }
}

class UnknownError extends ApiErrors {
  @override
  String get message => 'unknownError'.tr();
  UnknownError() : super(name: 'UnknownError');
}

class TimeoutError extends ApiErrors {
  @override
  String get message => 'timeoutError'.tr();
  TimeoutError() : super(name: 'TimeoutError');
}

class NoConnectionError extends ApiErrors {
  @override
  String get message => 'noConnectionError'.tr();
  NoConnectionError() : super(name: 'NoConnectionError');
}

class UnauthorizedError extends ApiErrors {
  @override
  String get message => 'unauthorizedError'.tr();
  UnauthorizedError() : super(name: 'UnauthorizeError');
}

class ServerResError extends ApiErrors {
  @override
  // ignore: overridden_fields
  final String message;
  ServerResError(this.message) : super(name: 'ServerResError');
}

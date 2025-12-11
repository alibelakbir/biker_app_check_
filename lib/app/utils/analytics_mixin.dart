import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

mixin AnalyticsMixin on GetxController {
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  /// Track page view with Firebase Analytics
  void trackPageView({
    required String pageName,
    String? pageClass,
    Map<String, Object>? parameters,
  }) {
    try {
      analytics.logScreenView(
        screenName: pageName,
        screenClass: pageClass ?? runtimeType.toString(),
        parameters: parameters,
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Track custom event
  void trackEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) {
    try {
      analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Track user engagement
  void trackEngagement({
    required String action,
    Map<String, dynamic>? additionalData,
  }) {
    try {
      analytics.logEvent(
        name: 'user_engagement',
        parameters: {
          'action': action,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?additionalData,
        },
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }
}

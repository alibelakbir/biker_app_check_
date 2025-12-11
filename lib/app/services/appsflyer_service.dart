import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:biker_app/app/config/appsflyer_config.dart';

class AppsFlyerService extends GetxService {
  static AppsFlyerService get to => Get.find();

  late AppsflyerSdk _appsflyerSdk;
  final StreamController<Map<String, dynamic>> _deepLinkStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get deepLinkStream =>
      _deepLinkStreamController.stream;

  @override
  void onInit() {
    super.onInit();
    _initAppsFlyer();
  }

  void _initAppsFlyer() {
    _appsflyerSdk = AppsflyerSdk({
      "afDevKey": AppsFlyerConfig.devKey,
      "afAppId": Platform.isIOS ? AppsFlyerConfig.iosAppId : null,
      "isDebug": AppsFlyerConfig.isDebug,
    });

    _appsflyerSdk.initSdk(
      registerConversionDataCallback: AppsFlyerConfig.enableConversionData,
      registerOnAppOpenAttributionCallback:
          AppsFlyerConfig.enableAppOpenAttribution,
      registerOnDeepLinkingCallback: AppsFlyerConfig.enableDeepLinking,
    );

    _setupDeepLinkCallbacks();
  }

  void _setupDeepLinkCallbacks() {
    try {
      // Deep link callback
      _appsflyerSdk.onDeepLinking((dp) {
        try {
          // Use string comparison to avoid enum issues
          final status = dp.status.toString();
          if (status.contains('FOUND')) {
            if (dp.deepLink != null) {
              // Handle deep link data
              _handleDeepLink(_extractDeepLinkData(dp.deepLink!));
            }
          } else if (status.contains('NOT_FOUND')) {
            print("Deep link not found");
          } else if (status.contains('ERROR')) {
            print("Deep link error: ${dp.error}");
          } else if (status.contains('PARSE_ERROR')) {
            print("Deep link parse error");
          }
        } catch (e) {
          print("Error in deep link callback: $e");
        }
      });

      // App open attribution callback
      _appsflyerSdk.onAppOpenAttribution((data) {
        try {
          if (data is Map<String, dynamic>) {
            _handleDeepLink(data);
          }
        } catch (e) {
          print("Error in app open attribution callback: $e");
        }
      });

      // Conversion data callback
      _appsflyerSdk.onInstallConversionData((data) {
        try {
          if (data is Map<String, dynamic>) {
            print("Conversion data: $data");
          }
        } catch (e) {
          print("Error in conversion data callback: $e");
        }
      });
    } catch (e) {
      print("Error setting up AppsFlyer callbacks: $e");
    }
  }

  Map<String, dynamic> _extractDeepLinkData(DeepLink deepLink) {
    // Primary: AppsFlyer passes parameters in clickEvent
    try {
      final Map<String, dynamic> clickEvent = deepLink.clickEvent;
      if (clickEvent.isNotEmpty) {
        return Map<String, dynamic>.from(clickEvent);
      }
    } catch (_) {}

    // Fallback: try parse from string representation if any
    try {
      final String s = deepLink.toString();
      if (s.contains('af_dp=')) {
        final uriString = Uri.decodeFull(s);
        return {'raw': uriString};
      }
    } catch (_) {}

    return {};
  }

  void _handleDeepLink(Map<String, dynamic> deepLinkData) {
    print("Deep link received: $deepLinkData");
    // If empty, try to parse from af_dp
    String? adId =
        deepLinkData['ad_id'] ?? deepLinkData['adId'] ?? deepLinkData['id'];
    String? adType =
        deepLinkData['type'] ??
        deepLinkData['ad_type'] ??
        deepLinkData['adType'];
    String? adCategory = deepLinkData['category'];
    // Also support clean OneLink params
    if (adId == null) {
      final String? sub1 = deepLinkData['af_sub1'] ?? deepLinkData['afSub1'];
      if (sub1 is String && sub1.isNotEmpty) adId = sub1;
    }
    if (adType == null) {
      final String? sub2 = deepLinkData['af_sub2'] ?? deepLinkData['afSub2'];
      if (sub2 is String && sub2.isNotEmpty) adType = sub2;
    }
    if (adCategory == null) {
      final String? sub3 = deepLinkData['af_sub3'] ?? deepLinkData['afSub3'];
      if (sub3 is String && sub3.isNotEmpty) adCategory = sub3;
    }

    if (adId != null) {
      // Navigate to advertisement details page
      _navigateToAdvertisementDetails(adId, adType, adCategory);
    }

    // Emit deep link data to stream
    _deepLinkStreamController.add(deepLinkData);
  }

  void _navigateToAdvertisementDetails(
    String adId,
    String? adType,
    String? adCategory,
  ) {
    try {
      final int id = int.parse(adId);
      final bool isMoto = adType == 'moto' || adType == 'motorcycle';

      log('pssst: $id  $isMoto');

      // Navigate using the expected argument type (page instance)
      Get.toNamed(
        AppRoutes.advertisementDetails,
        arguments: AdvertisementDetailsPage(
          id: id,
          isMoto: isMoto,
          category: adCategory ?? 'moto',
        ),
      );
    } catch (e) {
      print("Error parsing advertisement ID: $e");
    }
  }

  // Generate deep link for sharing advertisement
  String generateAdvertisementDeepLink({
    required int advertisementId,
    required String type,
    required String category,

    String? title,
    String? description,
  }) {
    // Build the inner app deep link (custom scheme)
    // Keep URL minimal: only identifiers for routing
    final Map<String, String> baseParams = {
      'ad_id': advertisementId.toString(),
      'type': type,
      'category': category,
    };

    // Build app deep link (kept for future use if needed by template or analytics)
    // final Uri appDeepLink = Uri(
    //   scheme: AppsFlyerConfig.deepLinkScheme,
    //   host: AppsFlyerConfig.deepLinkHost,
    //   queryParameters: baseParams,
    // );

    // Minimal OneLink using AppsFlyer-recommended keys for clean passthrough
    final Uri oneLink = Uri(
      scheme: 'https',
      host: AppsFlyerConfig.oneLinkDomain,
      pathSegments: [AppsFlyerConfig.oneLinkId],
      queryParameters: <String, String>{
        // Clean keys. Configure template to map these to app/web routing.
        'deep_link_value': 'advertisement',
        'af_sub1': baseParams['ad_id']!,
        'af_sub2': baseParams['type']!,
        'af_sub3': baseParams['category']!,
        // Optional: basic attribution
        'pid': 'share',
        'c': 'ad_share',
      },
    );

    return oneLink.toString();
  }

  // Track custom events
  void logEvent(String eventName, Map<String, dynamic> eventValues) {
    _appsflyerSdk.logEvent(eventName, eventValues);
  }

  // Track advertisement view
  void logAdvertisementView(int advertisementId, String type) {
    logEvent('advertisement_view', {
      'advertisement_id': advertisementId,
      'type': type,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Track advertisement share
  void logAdvertisementShare(
    int advertisementId,
    String type,
    String shareMethod,
  ) {
    logEvent('advertisement_share', {
      'advertisement_id': advertisementId,
      'type': type,
      'share_method': shareMethod,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Track user engagement
  void logUserEngagement(String action, Map<String, dynamic> additionalData) {
    logEvent('user_engagement', {
      'action': action,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      ...additionalData,
    });
  }

  @override
  void onClose() {
    _deepLinkStreamController.close();
    super.onClose();
  }
}

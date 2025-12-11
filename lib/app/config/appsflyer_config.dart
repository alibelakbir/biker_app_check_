class AppsFlyerConfig {
  // AppsFlyer Dev Key - Replace with your actual key from AppsFlyer dashboard
  static const String devKey = "xzw6gEmQpSm3cyfpVVmRog";

  // iOS App ID - Replace with your actual App Store ID
  static const String iosAppId = "YOUR_IOS_APP_ID";

  // Android Package Name - Update with your actual package name
  static const String androidPackageName = "com.bikerapp.ma";

  // Custom Domain for OneLinks (optional)
  static const String customDomain = "https://biker.ma";

  // AppsFlyer OneLink domain (e.g., biker.onelink.me)
  static const String oneLinkDomain = "biker.onelink.me";

  // AppsFlyer OneLink template ID (path segment), shown as meta-data ONE_LINK_ID in AndroidManifest
  static const String oneLinkId = "fhZz";

  // Deep Link Scheme
  static const String deepLinkScheme = "bikerapp";

  // Deep Link Host
  static const String deepLinkHost = "advertisement";

  // Debug Mode - Set to false for production
  static const bool isDebug = true;

  // Enable Deep Link Validation
  static const bool enableDeepLinkValidation = true;

  // Enable Conversion Data
  static const bool enableConversionData = true;

  // Enable App Open Attribution
  static const bool enableAppOpenAttribution = true;

  // Enable Deep Linking
  static const bool enableDeepLinking = true;
}

# AppsFlyer Deep Link Integration Setup

This guide explains how to set up AppsFlyer deep linking for the Biker App to enable sharing and handling advertisement details pages.

## Prerequisites

1. AppsFlyer account and dashboard access
2. Flutter development environment
3. iOS and Android development setup

## Setup Steps

### 1. AppsFlyer Dashboard Configuration

1. **Create a New App** in AppsFlyer dashboard
2. **Get your Dev Key** from the app settings
3. **Configure OneLinks** for deep linking
4. **Set up Attribution** for app install tracking

### 2. Update Configuration

Edit `lib/app/config/appsflyer_config.dart`:

```dart
class AppsFlyerConfig {
  // Replace with your actual AppsFlyer Dev Key
  static const String devKey = "YOUR_ACTUAL_APPSFLYER_DEV_KEY";
  
  // Replace with your iOS App Store ID
  static const String iosAppId = "YOUR_ACTUAL_IOS_APP_ID";
  
  // Update with your actual Android package name
  static const String androidPackageName = "com.yourcompany.biker_app";
  
  // Update with your custom domain if using OneLinks
  static const String customDomain = "https://yourdomain.com";
  
  // Set to false for production
  static const bool isDebug = false;
}
```

### 3. iOS Configuration

#### Info.plist Updates

Add the following to your `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.yourcompany.biker_app</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>bikerapp</string>
        </array>
    </dict>
</array>

<key>LSApplicationQueriesSchemes</key>
<array>
    <string>whatsapp</string>
    <string>fb</string>
    <string>twitter</string>
</array>
```

#### Associated Domains

Add associated domains for OneLinks:

```xml
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:yourdomain.com</string>
</array>
```

### 4. Android Configuration

#### AndroidManifest.xml Updates

Add the following to your `android/app/src/main/AndroidManifest.xml`:

```xml
<activity>
    <!-- ... existing activity configuration ... -->
    
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        
        <!-- Custom scheme -->
        <data android:scheme="bikerapp" />
        
        <!-- OneLink domain -->
        <data android:scheme="https"
              android:host="yourdomain.com" />
    </intent-filter>
</activity>
```

### 5. Deep Link Testing

#### Test Custom Scheme

Test the custom scheme deep link:
```
bikerapp://advertisement?ad_id=123&type=moto&title=Test%20Ad
```

#### Test OneLink

Test OneLink deep linking:
```
https://yourdomain.com/advertisement?ad_id=123&type=moto
```

### 6. Features Implemented

#### Advertisement Sharing

- **WhatsApp Sharing**: Generates deep link and shares via WhatsApp
- **Facebook Sharing**: Shares advertisement on Facebook with deep link
- **Twitter Sharing**: Tweets advertisement with deep link
- **Copy Link**: Copies deep link to clipboard

#### Deep Link Handling

- **Automatic Navigation**: Opens advertisement details page when deep link is clicked
- **Parameter Parsing**: Extracts advertisement ID and type from deep links
- **Fallback Handling**: Graceful handling of invalid deep links

#### Analytics Tracking

- **Advertisement Views**: Tracks when users view advertisements
- **Share Events**: Tracks sharing actions and methods
- **User Engagement**: Tracks user interactions with the app

### 7. Usage Examples

#### Sharing an Advertisement

```dart
// Generate deep link for sharing
final deepLink = AppsFlyerService.to.generateAdvertisementDeepLink(
  advertisementId: 123,
  type: 'moto',
  title: 'BMW R1250GS',
  description: 'Amazing adventure motorcycle!',
);

// Share via WhatsApp
final whatsappUrl = 'whatsapp://send?text=${Uri.encodeComponent(
  'Check out this motorcycle: $deepLink'
)}';
```

#### Handling Deep Links

```dart
// Listen to deep link events
AppsFlyerService.to.deepLinkStream.listen((deepLinkData) {
  print('Deep link received: $deepLinkData');
  // Handle deep link data
});
```

### 8. Troubleshooting

#### Common Issues

1. **Deep links not working**: Check URL scheme configuration in iOS/Android
2. **OneLinks not redirecting**: Verify associated domains and intent filters
3. **Analytics not showing**: Ensure AppsFlyer Dev Key is correct
4. **Sharing not working**: Check social media app availability

#### Debug Mode

Enable debug mode in `appsflyer_config.dart`:
```dart
static const bool isDebug = true;
```

Check console logs for AppsFlyer events and deep link handling.

### 9. Production Checklist

- [ ] Set `isDebug = false` in configuration
- [ ] Verify OneLink domain configuration
- [ ] Test deep links on both platforms
- [ ] Verify analytics tracking in AppsFlyer dashboard
- [ ] Test sharing functionality on real devices
- [ ] Update AppsFlyer Dev Key and iOS App ID

### 10. Support

For AppsFlyer-specific issues:
- [AppsFlyer Documentation](https://dev.appsflyer.com/)
- [AppsFlyer Support](https://support.appsflyer.com/)

For app-specific issues:
- Check the console logs for error messages
- Verify configuration values
- Test on both iOS and Android devices


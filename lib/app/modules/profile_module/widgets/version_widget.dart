import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({super.key, this.prefixText = 'Version'});

  final String prefixText;

  // Function to fetch package info
  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _getPackageInfo(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          final String version = snapshot.data!.version;
          final String buildNumber = snapshot.data!.buildNumber;

          // Display the version and build number
          return Text(
            'V$version ($buildNumber)',
            style: AppTextStyles.base.s11.w400.grayColor,
          );
        } else if (snapshot.hasError) {
          // Display an error if fetching failed
          return const SizedBox.shrink();
        }

        // Display a loading indicator while waiting
        return const SizedBox.shrink();
      },
    );
  }
}

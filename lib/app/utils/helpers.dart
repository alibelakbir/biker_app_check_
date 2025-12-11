import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Helpers {
  Helpers._();

  static Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static getMediaList(Map<dynamic, String> map) {
    List<String> medias = [];
    for (int i = 0; i < 6; i++) {
      if (map['photo$i'] != null) medias.add(map['photo$i'] as String);
    }
    return medias;
  }

  static String formatPrice(num? number) {
    if (number == null || number == 0) return 'Prix non spécifié';
    final str = number.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < str.length; i++) {
      if (i != 0 && (str.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(str[i]);
    }

    return '$buffer DH';
  }

  static Future<void> openTel(String phone) async {
    if (!await launchUrlString('tel:$phone')) {
      throw 'Could not launch $phone';
    }
  }

  static etatAnnonce(String etat) {
    final style = AppTextStyles.base.s12.w400;
    switch (etat) {
      case 'active':
        return Text(
          'Active',
          style: style.copyWith(color: AppColors.kPrimaryColor),
        );
      case 'desactive':
        return Text(
          'Désactivé',
          style: style.copyWith(color: Color(0xFFCD2C2C)),
        );
      default:
        return Text(
          'En attente',
          style: style.copyWith(color: Color(0xFFFEBC32)),
        );
    }
  }

  static String normalizeMoroccanPhone(String input) {
    return '%2B212$input'; // Invalid format
  }

  static openWhatsappChat(String phoneNumber, {String? message}) async {
    final encodedMessage = Uri.encodeComponent(message ?? 'Hello! 👋');

    // URL scheme for launching WhatsApp chat
    final Uri uri = Uri.parse(
      'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
    );

    // Check if WhatsApp can be launched on the device
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Fallback for devices without WhatsApp installed (e.g., web, certain platforms)
      final Uri fallbackUri = Uri.parse(
        'https://wa.me/$phoneNumber?text=$encodedMessage',
      );
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } else {
        // Handle the case where WhatsApp cannot be opened
        debugPrint('Could not launch WhatsApp or its web version.');
      }
    }
  }

  static getCategoryByIndex(int index) {
    switch (index) {
      case 1:
        return 'equipement-motard';
      case 2:
        return 'equipement-moto';
      case 3:
        return 'piece-rechange';
      case 4:
        return 'pneu';
      default:
        return 'moto';
    }
  }

  static Future<PackageInfo> getAppInfos() async {
    return await PackageInfo.fromPlatform();
  }
}

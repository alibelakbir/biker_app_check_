import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;

import 'enums.dart';

class Common {
  Common._();

  static void showError(String error, {bool isDarkMode = false}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            error,
            style: AppTextStyles.base.w400.s12.copyWith(
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        borderRadius: 12,
        backgroundColor: AppColors.white,
        duration: const Duration(milliseconds: 2000),
        snackPosition: SnackPosition.TOP,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.red.withOpacity(0.2),
            child: const Icon(Icons.error, color: AppColors.red),
          ),
        ),
        boxShadows: const [kCardShadow],
        overlayBlur: 2,
        onTap: (snack) => Get.back(),
      ),
    );
  }

  static void showSuccess({String? title}) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Row(
          children: [
            SvgPicture.asset('assets/icon/success.svg'),
            const SizedBox(width: 12),
            Text('Success', style: AppTextStyles.base.s14.w500.kPrimaryColor),
          ],
        ),
        messageText: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            title ?? 'Message was successfully sent',
            style: AppTextStyles.base.w400.s12.copyWith(
              color: const Color(0xFF131321),
            ),
          ),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        borderRadius: 12,
        backgroundColor: AppColors.white,
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        boxShadows: const [kCardShadow],
        overlayBlur: 0,
        onTap: (snack) => Get.back(),
      ),
    );
  }

  static void showLoading() {
    Get.dialog(
      Center(
        child: SpinKitSpinningCircle(size: 50, color: AppColors.kPrimaryColor),
      ),
      barrierColor: AppColors.black.withOpacity(0.6),
      barrierDismissible: true,
      transitionCurve: Curves.easeInOutBack,
    );
  }

  static void closeLoading() {
    Get.closeAllSnackbars();
    Get.back();
  }

  static Future<bool> showConfirm({String? title, String? content}) async {
    bool result = false;
    await Get.dialog(
      Platform.isIOS
          ? CupertinoAlertDialog(
            title: Text(
              title ?? easy_localization.tr('delete_confirmation'),
              style: AppTextStyles.base.w700.s16.whiteColor,
              textAlign: TextAlign.center,
            ),
            content: Text(
              easy_localization.tr(
                'are_you_sure_delete',
                args: [content ?? "feature"],
              ),
              style: AppTextStyles.base.w400.s16.whiteColor,
              textAlign: TextAlign.center,
            ),
            actions: [
              CupertinoButton(
                child: Text(
                  easy_localization.tr('cancel'),
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
              ),
              CupertinoButton(
                child: Text(easy_localization.tr('confirm')),
                onPressed: () {
                  result = true;
                  if (Get.isDialogOpen!) Get.back();
                },
              ),
            ],
          )
          : AlertDialog(
            title: Text(
              title ?? 'Delete confirmation',
              style: AppTextStyles.base.w700.s16.whiteColor,
            ),
            content: Text(
              title ?? 'Are you sure you want to delete this feature?',
              style: AppTextStyles.base.w400.s16.whiteColor,
            ),
            actions: [
              CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
              ),
              CupertinoButton(
                child: const Text('Confirm'),
                onPressed: () {
                  result = true;
                  if (Get.isDialogOpen!) Get.back();
                },
              ),
            ],
          ),
      barrierColor: Colors.black26,
      transitionCurve: Curves.easeInOutBack,
    );
    return result;
  }

  static Future<List<String>> getImagefromGallery({
    PickerType? pickerType,
  }) async {
    List<String> files = [];
    try {
      switch (pickerType) {
        case PickerType.multiImage:
          final images = await ImagePicker().pickMultiImage();
          if (images.isNotEmpty) files = images.map((e) => e.path).toList();
          break;

        case PickerType.media:
          final media = await Get.find<ImagePicker>().pickMedia();
          if (media != null) files.add(media.path);
          break;

        case PickerType.multipleMedia:
          final medias = await Get.find<ImagePicker>().pickMultipleMedia();
          if (medias.isNotEmpty) files = medias.map((e) => e.path).toList();
          break;

        case PickerType.video:
          final video = await Get.find<ImagePicker>().pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(minutes: 1),
          );
          if (video != null) files.add(video.path);
          break;
        case PickerType.image:
          log('pickImage');
          final image = await Get.find<ImagePicker>().pickImage(
            source: ImageSource.camera,
          );
          if (image != null) files.add(image.path);
          break;
        default:
          final image = await Get.find<ImagePicker>().pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) files.add(image.path);
          break;
      }
    } on PlatformException catch (e) {
      Common.showError(e.message ?? 'Invalid image format!');
    } finally {
      // ignore: control_flow_in_finally
      return files;
    }
  }

  static Future<List<String>> compressImages(
    List<String> files, {
    int quality = 70,
  }) async {
    try {
      log('hello');
      final List<String> compressedFiles = [];
      final tempDir = await getTemporaryDirectory();
      log(tempDir.path);

      final uuid = const Uuid();

      for (String file in files) {
        final targetPath = '${tempDir.path}/${uuid.v4()}.jpg';
        log(targetPath);

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          file,
          targetPath,
          quality: quality,
        );

        if (compressedFile != null) {
          compressedFiles.add(compressedFile.path);
        }
      }
      return compressedFiles;
    } catch (e) {
      log('$e');
      return [];
    }
  }

  static void dismissKeyboard() => Get.focusScope!.unfocus();
}

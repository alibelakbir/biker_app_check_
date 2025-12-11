import 'dart:io';

import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_raduis.dart';

class FileWidget extends StatelessWidget {
  final String filePath;
  final Function()? onDelete;
  final double? height;
  final bool isPrimary;
  const FileWidget(
      {super.key,
      required this.filePath,
      this.onDelete,
      this.height,
      this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        filePath.contains('https')
            ? CachedImage(
                imageUrl: filePath,
                borderRadius: kRadius4,
                enableBorder: false,
              )
            : Container(
                height: height,
                decoration: BoxDecoration(
                    borderRadius: kRadius4,
                    image: DecorationImage(
                        image: FileImage(File(filePath)), fit: BoxFit.cover)),
              ),
        onDelete != null
            ? GestureDetector(
                onTap: onDelete,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    //constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0A1A28).withOpacity(0.4),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 12,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        isPrimary
            ? Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color(0xFF0A1A28).withOpacity(0.7),
                    borderRadius: kRadius4),
                child: Text(
                  'Photo principale',
                  style: AppTextStyles.base.s9.w500.whiteColor,
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }
}

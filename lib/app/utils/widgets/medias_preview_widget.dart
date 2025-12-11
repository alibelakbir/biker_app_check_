import 'package:biker_app/app/utils/widgets/app_button/dotted_button.dart';

import 'file_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MediasPreviewWidget extends StatelessWidget {
  final List<String> medias;
  final String? mainPhoto;
  final Function() onPickImage;

  const MediasPreviewWidget(
      {super.key,
      required this.medias,
      this.mainPhoto,
      required this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: medias.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return medias[index].isEmpty
                ? DottedButton(
                    text: 'Choisir une photo',
                    ontap: onPickImage,
                  )
                : FileWidget(
                    filePath: medias[index],
                    onDelete: () => medias.removeAt(index),
                    isPrimary: index == 0,
                  );
          },
        ));
  }
}

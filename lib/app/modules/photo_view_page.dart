import 'dart:developer';

import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewerPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String? type;

  const PhotoViewerPage({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.type,
  });

  @override
  State<PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<PhotoViewerPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicatorDots() {
    if (widget.imageUrls.length <= 1) return SizedBox.shrink();

    return Positioned(
      bottom: kToolbarHeight,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.imageUrls.length, (index) {
          final isActive = index == _currentIndex;
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 12 : 8,
            height: isActive ? 12 : 8,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSingle = widget.imageUrls.length == 1;

    log('Gallery 2: ${widget.imageUrls.map((e) => e)}');

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            isSingle
                ? Center(
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        widget.type != null
                            ? EndPoints.brandMotoMediaUrl(widget.imageUrls[0])!
                            : EndPoints.mediaUrl(widget.imageUrls[0])!,
                      ),
                      backgroundDecoration: BoxDecoration(color: Colors.black),
                    ),
                  )
                : PhotoViewGallery.builder(
                    itemCount: widget.imageUrls.length,
                    // pageController: PageController(initialPage: widget.initialIndex),
                    pageController: _pageController,
                    onPageChanged: (index) => setState(() {
                      _currentIndex = index;
                    }),
                    builder: (context, index) {
                      log(widget.type ?? 'walo type');
                      log('photo: ${widget.type != null ? EndPoints.brandMotoMediaUrl(widget.imageUrls[index])! : EndPoints.mediaUrl(widget.imageUrls[index])!}');
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                          widget.type != null
                              ? EndPoints.brandMotoMediaUrl(
                                  widget.imageUrls[index])!
                              : EndPoints.mediaUrl(widget.imageUrls[index])!,
                        ),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2.5,
                      );
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(color: Colors.black),
                    loadingBuilder: (context, progress) => Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
            _buildIndicatorDots(),
            Positioned(
                top: kToolbarHeight + 16, left: 16, child: BackOvalWidget())
          ],
        ));
  }
}

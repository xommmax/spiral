import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/full_screen_publication_media_widget.dart';
import 'package:dairo/presentation/view/base/widget_video_preview.dart';
import 'package:flutter/material.dart';

class WidgetPublicationMediaPreview extends StatelessWidget {
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final bool local;

  WidgetPublicationMediaPreview(this.mediaFiles, this.currentIndex,
      {this.local = false});

  @override
  Widget build(BuildContext context) {
    final file = mediaFiles[currentIndex];
    return FullScreenPublicationMediaWidget(
      child: ClipRRect(
        child: file.type == MediaType.image
            ? local
                ? Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: file.path,
                    fit: BoxFit.cover,
                  )
            : WidgetVideoPreview(filePath: file.path),
      ),
      mediaFiles: mediaFiles,
      currentIndex: currentIndex,
      local: local,
    );
  }
}

class WidgetPublicationMediaGridPreview extends StatelessWidget {
  final List<MediaFile> mediaFiles;

  WidgetPublicationMediaGridPreview(this.mediaFiles);

  @override
  Widget build(BuildContext context) => GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: mediaFiles.map((file) {
          int position = mediaFiles.indexOf(file);
          return WidgetPublicationMediaPreview(mediaFiles, position);
        }).toList(),
        crossAxisCount: 3,
      );
}

class WidgetPublicationMediaCarouselPreview extends StatefulWidget {
  final List<MediaFile> mediaFiles;

  WidgetPublicationMediaCarouselPreview(this.mediaFiles);

  @override
  State<StatefulWidget> createState() =>
      WidgetPublicationMediaCarouselPreviewState();
}

class WidgetPublicationMediaCarouselPreviewState
    extends State<WidgetPublicationMediaCarouselPreview> {
  final CarouselController carouselController = CarouselController();
  int currentMediaCarouselIndex = 0;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            items: widget.mediaFiles.map((file) {
              int position = widget.mediaFiles.indexOf(file);
              return WidgetPublicationMediaPreview(widget.mediaFiles, position);
            }).toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              disableCenter: true,
              onPageChanged: onCarouselPageChanged,
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xFF000000),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Text(
                "${currentMediaCarouselIndex + 1}/${widget.mediaFiles.length}",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (currentMediaCarouselIndex != 0)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0x40000000),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: AppColors.white,
                          ),
                          onPressed: () => carouselController.previousPage(),
                        ),
                      )
                    : SizedBox.shrink(),
                (currentMediaCarouselIndex != widget.mediaFiles.length - 1)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0x40000000),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.white,
                          ),
                          onPressed: () => carouselController.nextPage(),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      );

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) =>
      setState(() => currentMediaCarouselIndex = index);
}

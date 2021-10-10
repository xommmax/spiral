import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/full_screen_publication_media_widget.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetNewPublicationMediaPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  final int index;

  WidgetNewPublicationMediaPreview(this.index);

  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    final file = viewModel.viewData.mediaFiles[index];
    return FullScreenPublicationMediaWidget(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            file.previewImage,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 4,
            top: 4,
            child: CircleAvatar(
              backgroundColor: AppColors.black,
              radius: 16,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
                onPressed: () => viewModel.removeMedia(index),
              ),
            ),
          ),
          file.type == MediaType.video
              ? Align(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x80000000),
                    child: Icon(
                      Icons.play_arrow,
                      color: AppColors.black,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      localMediaFiles: viewModel.viewData.mediaFiles,
      currentIndex: index,
    );
  }
}

class WidgetNewPublicationMediaGridPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: viewModel.viewData.mediaFiles.map((file) {
          int position = viewModel.viewData.mediaFiles.indexOf(file);
          return WidgetNewPublicationMediaPreview(position);
        }).toList(),
        crossAxisCount: 3,
      );
}

class WidgetNewPublicationMediaCarouselPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            items: viewModel.viewData.mediaFiles.map((file) {
              int position = viewModel.viewData.mediaFiles.indexOf(file);
              return WidgetNewPublicationMediaPreview(position);
            }).toList(),
            carouselController: viewModel.buttonCarouselController,
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
              onPageChanged: viewModel.onCarouselPageChanged,
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
                "${viewModel.currentMediaCarouselIndex + 1}/${viewModel.viewData.mediaFiles.length}",
                style: TextStyle(
                  color: AppColors.black,
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
                (viewModel.currentMediaCarouselIndex != 0)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0x40000000),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: AppColors.black,
                          ),
                          onPressed: () =>
                              viewModel.buttonCarouselController.previousPage(),
                        ),
                      )
                    : SizedBox.shrink(),
                (viewModel.currentMediaCarouselIndex !=
                        viewModel.viewData.mediaFiles.length - 1)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0x40000000),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.black,
                          ),
                          onPressed: () =>
                              viewModel.buttonCarouselController.nextPage(),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      );
}

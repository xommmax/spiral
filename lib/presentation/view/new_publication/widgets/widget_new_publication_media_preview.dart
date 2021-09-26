import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

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
          return _bindItem(
            viewModel.viewData.mediaFiles,
            position,
            () => viewModel.removeMedia(position),
          );
        }).toList(),
        crossAxisCount: 3,
      );
}

Widget _bindItem(List<MediaFile> files, int position, VoidCallback onPressed) =>
    Stack(
      fit: StackFit.expand,
      children: [
        WidgetPublicationMediaPreview(files, position, local: true),
        Positioned(
          left: 8,
          top: 8,
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Color(0x20FF0000),
            child: IconButton(
              icon: Text(
                '—',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );

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
              return _bindItem(
                viewModel.viewData.mediaFiles,
                position,
                () => viewModel.removeMedia(position),
              );
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
                (viewModel.currentMediaCarouselIndex != 0)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0x40000000),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: AppColors.white,
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
                            color: AppColors.white,
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

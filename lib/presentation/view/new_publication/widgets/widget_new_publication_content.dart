import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/input_field_new_publication.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_new_publication.dart';

class WidgetNewPublicationContent
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    var padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        Dimens.toolBarHeight;

    return Scaffold(
        appBar: AppBarNewPublication(),
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (viewModel.viewData.mediaFiles.length != 0)
                      _MediaBlock(),
                    InputFieldNewPublication(),
                    SizedBox(height: 380),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            color: AppColors.gray,
                            spreadRadius: 4,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: _MediaTypePicker(),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onDonePressed,
          child: Icon(
            Icons.check,
            color: AppColors.black,
          ),
          backgroundColor: AppColors.primaryColor,
        ));
  }
}

class _WidgetSwitchMediaPreviewType
    extends ViewModelWidget<NewPublicationViewModel> {
  const _WidgetSwitchMediaPreviewType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.view_carousel_outlined),
              iconSize: 28,
              color: viewModel.mediaPreviewTypeIndex == 0
                  ? AppColors.black
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaPreviewTypeIndexChanged(0),
            ),
            IconButton(
              icon: Icon(Icons.grid_on),
              iconSize: 28,
              color: viewModel.mediaPreviewTypeIndex == 1
                  ? AppColors.black
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaPreviewTypeIndexChanged(1),
            ),
          ],
        ),
      );
}

class _MediaBlock extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Column(
        children: [
          _WidgetSwitchMediaPreviewType(),
          IndexedStack(
            index: viewModel.mediaPreviewTypeIndex,
            children: [
              WidgetNewPublicationMediaCarouselPreview(),
              WidgetNewPublicationMediaGridPreview(),
            ],
          ),
        ],
      );
}

class _MediaTypePicker extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MediaTypePickerOption(Icons.photo, 'Gallery',
                    () => viewModel.onGalleryMediaItemPicked(context)),
                _MediaTypePickerOption(Icons.audiotrack_rounded, 'Audio',
                    () => viewModel.onAudioMediaItemPicked(context)),
              ],
            ),
            Divider(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MediaTypePickerOption(
                    Icons.text_fields, 'Text', viewModel.onTextMediaItemPicked),
                _MediaTypePickerOption(
                    Icons.link, 'Link', viewModel.onLinkMediaItemPicked),
                _MediaTypePickerOption(
                    Icons.attach_file, 'File', viewModel.onFileMediaItemPicked),
              ],
            ),
          ],
        ),
      );
}

class _MediaTypePickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onPressed;

  _MediaTypePickerOption(this.icon, this.label, this.onPressed);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Icon(
              icon,
              color: AppColors.darkGray,
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size.square(48)),
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(AppColors.lightGray),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ],
      );
}

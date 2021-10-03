import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class MediaTypePickerContainer
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.gray,
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: viewModel.isTypePickerCollapsed
          ? _MediaTypePickerCollapsed()
          : _MediaTypePickerExpanded(),
    );
  }
}

class _MediaTypePickerCollapsed
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MediaTypePickerOption(
              Icons.photo,
              'Gallery',
              () => viewModel.onGalleryMediaItemPicked(context),
              viewModel.isMediaBlockVisible),
          _MediaTypePickerOption(Icons.text_fields, 'Text',
              viewModel.onTextMediaItemPicked, viewModel.isTextBlockVisible),
          _MediaTypePickerOption(Icons.link, 'Link',
              viewModel.onLinkMediaItemPicked, viewModel.isLinkBlockVisible),
          _MediaTypePickerOption(Icons.attach_file, 'File',
              viewModel.onFileMediaItemPicked, viewModel.isFileBlockVisible),
        ],
      ),
    );
  }
}

class _MediaTypePickerExpanded
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: EdgeInsets.only(top: 32, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MediaTypePickerOption(
                    Icons.photo,
                    'Gallery',
                    () => viewModel.onGalleryMediaItemPicked(context),
                    viewModel.isMediaBlockVisible),
                _MediaTypePickerOption(
                  Icons.audiotrack_rounded,
                  'Audio',
                  () => viewModel.onAudioMediaItemPicked(context),
                  false,
                  isDisabled: true,
                ),
              ],
            ),
            Divider(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MediaTypePickerOption(
                    Icons.text_fields,
                    'Text',
                    viewModel.onTextMediaItemPicked,
                    viewModel.isTextBlockVisible),
                _MediaTypePickerOption(
                    Icons.link,
                    'Link',
                    viewModel.onLinkMediaItemPicked,
                    viewModel.isLinkBlockVisible),
                _MediaTypePickerOption(
                    Icons.attach_file,
                    'File',
                    viewModel.onFileMediaItemPicked,
                    viewModel.isFileBlockVisible),
              ],
            ),
          ],
        ),
      );
}

class _MediaTypePickerOption extends ViewModelWidget<NewPublicationViewModel> {
  final IconData icon;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  final bool isDisabled;

  _MediaTypePickerOption(this.icon, this.label, this.onPressed, this.isSelected,
      {this.isDisabled = false});

  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    double buttonSize;
    double iconSize;
    Color buttonColor;
    Color iconColor;
    Color textColor;
    if (viewModel.isTypePickerCollapsed) {
      buttonSize = 24;
      iconSize = 20;
    } else {
      buttonSize = 48;
      iconSize = 24;
    }
    if (isSelected) {
      buttonColor = AppColors.accentColor;
      iconColor = AppColors.white;
      textColor = AppColors.black;
    } else if (isDisabled) {
      buttonColor = AppColors.disabledGray;
      iconColor = AppColors.lightGray;
      textColor = AppColors.lightGray;
    } else {
      buttonColor = AppColors.lightGray;
      iconColor = AppColors.darkGray;
      textColor = AppColors.darkGray;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.square(buttonSize)),
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
        ),
        if (!viewModel.isTypePickerCollapsed)
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                )),
          ),
      ],
    );
  }
}

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
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
        color: AppColors.darkAccentColor,
        border: Border(
          top: BorderSide(
            color: AppColors.darkGray,
            width: 0.3,
          ),
        ),
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
            icon: Icons.photo,
            label: 'Gallery',
            isSelected: viewModel.isMediaBlockVisible,
            onPressed: () => viewModel.onGalleryMediaItemPicked(context),
          ),
          _MediaTypePickerOption(
            icon: Icons.text_fields,
            label: 'Text',
            isSelected: viewModel.isTextBlockVisible,
            onPressed: viewModel.onTextMediaItemPicked,
          ),
          _MediaTypePickerOption(
            icon: Icons.attach_file,
            label: 'File',
            isSelected: viewModel.isFileBlockVisible,
            onPressed: viewModel.onFileMediaItemPicked,
          ),
          _MediaTypePickerOption(
            icon: Icons.link,
            label: 'Link',
            isSelected: viewModel.isLinkBlockVisible,
            onPressed: viewModel.onLinkMediaItemPicked,
          ),
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
                  icon: Icons.photo,
                  label: 'Gallery',
                  isSelected: viewModel.isMediaBlockVisible,
                  onPressed: () => viewModel.onGalleryMediaItemPicked(context),
                ),
                Stack(alignment: Alignment.center, children: [
                  _MediaTypePickerOption(
                    icon: Icons.audiotrack_rounded,
                    label: 'Audio',
                    isSelected: false,
                    onPressed: () => viewModel.onAudioMediaItemPicked(context),
                    isDisabled: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Color(0x8047125D),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      Strings.comingSoon,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Divider(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MediaTypePickerOption(
                  icon: Icons.text_fields,
                  label: 'Text',
                  isSelected: viewModel.isTextBlockVisible,
                  onPressed: viewModel.onTextMediaItemPicked,
                ),
                _MediaTypePickerOption(
                  icon: Icons.attach_file,
                  label: 'File',
                  isSelected: viewModel.isFileBlockVisible,
                  onPressed: viewModel.onFileMediaItemPicked,
                ),
                _MediaTypePickerOption(
                  icon: Icons.link,
                  label: 'Link',
                  isSelected: viewModel.isLinkBlockVisible,
                  onPressed: viewModel.onLinkMediaItemPicked,
                ),
              ],
            ),
          ],
        ),
      );
}

class _MediaTypePickerOption extends ViewModelWidget<NewPublicationViewModel> {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isDisabled;

  _MediaTypePickerOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.isDisabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    double buttonSize;
    double iconSize;
    Color buttonColor;
    Color iconColor;
    Color textColor;
    if (viewModel.isTypePickerCollapsed) {
      buttonSize = 36;
      iconSize = 20;
    } else {
      buttonSize = 48;
      iconSize = 24;
    }
    if (isSelected) {
      buttonColor = AppColors.accentColor;
      iconColor = AppColors.white;
      textColor = AppColors.white;
    } else if (isDisabled) {
      buttonColor = AppColors.darkGray;
      iconColor = AppColors.gray;
      textColor = AppColors.gray;
    } else {
      buttonColor = AppColors.darkestGray;
      iconColor = AppColors.lightGray;
      textColor = AppColors.lightGray;
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

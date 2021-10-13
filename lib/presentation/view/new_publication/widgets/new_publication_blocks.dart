import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/new_publication_media_preview.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

/*
  Media Block
 */
class MediaBlock extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Column(
        children: [
          _WidgetSwitchMediaPreviewType(),
          IndexedStack(
            index: viewModel.mediaViewTypeIndex,
            children: [
              WidgetNewPublicationMediaCarouselPreview(),
              WidgetNewPublicationMediaGridPreview(),
            ],
          ),
        ],
      );
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
              color: viewModel.mediaViewTypeIndex == 0
                  ? AppColors.white
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaViewTypeIndexChanged(0),
            ),
            IconButton(
              icon: Icon(Icons.grid_on),
              iconSize: 28,
              color: viewModel.mediaViewTypeIndex == 1
                  ? AppColors.white
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaViewTypeIndexChanged(1),
            ),
          ],
        ),
      );
}

/*
  Text Block
 */

class TextBlock extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: EdgeInsets.fromLTRB(
            16,
            ((viewModel.isTextEditorPanelVisible &&
                    !viewModel.isMediaBlockVisible)
                ? 72
                : 16),
            16,
            16),
        child: quill.QuillEditor(
          controller: viewModel.textEditorController,
          scrollController: viewModel.scrollController,
          scrollable: false,
          focusNode: viewModel.textBlockFocusNode,
          autoFocus: false,
          readOnly: false,
          expands: false,
          padding: EdgeInsets.zero,
          keyboardAppearance: Brightness.dark,
          scrollBottomInset: 88,
          placeholder: 'Write a message',
          customStyles: quill.DefaultStyles(
            placeHolder: quill.DefaultTextBlockStyle(
              TextStyle(
                fontSize: 16,
                color: AppColors.gray,
              ),
              const Tuple2(0, 0),
              const Tuple2(0, 0),
              null,
            ),
          ),
        ),
      );
}

/*
  Link Block
 */

class LinkBlock extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 88),
          focusNode: viewModel.linkBlockFocusNode,
          autofocus: false,
          onChanged: (s) => viewModel.notifyListeners(),
          controller: viewModel.publicationLinkController,
          decoration: InputDecoration(
            icon: Icon(
              Icons.link,
              color: viewModel.isLinkValid()
                  ? AppColors.linkText
                  : AppColors.errorRedColor,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          style: TextStyle(
            color: AppColors.linkText,
          ),
          keyboardType: TextInputType.url,
        ),
      );
}

/*
    File Block
 */

class FileBlock extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    if (viewModel.viewData.attachedFile == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.accentColor, shape: BoxShape.circle),
            child: Icon(
              Icons.insert_drive_file,
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.viewData.attachedFile!.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  getFileSizeString(viewModel.viewData.attachedFile!.size),
                  style: TextStyle(color: AppColors.darkGray, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

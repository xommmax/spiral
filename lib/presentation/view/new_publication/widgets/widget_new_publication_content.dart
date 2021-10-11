import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/new_publication_blocks.dart';
import 'package:dairo/presentation/view/new_publication/widgets/new_publication_type_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:stacked/stacked.dart';

import 'appbar_new_publication.dart';

class WidgetNewPublicationContent
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    return Scaffold(
      appBar: AppBarNewPublication(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (!viewModel.isAnyBlockVisible())
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  Strings.whatWantToPost,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            Listener(
              onPointerDown: (event) =>
                  viewModel.onContentPointerDown(event, context),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                controller: viewModel.scrollController,
                padding: EdgeInsets.only(bottom: 56),
                child: Builder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (viewModel.isMediaBlockVisible) MediaBlock(),
                      if (viewModel.isTextBlockVisible) TextBlock(),
                      if (viewModel.isLinkBlockVisible) LinkBlock(),
                      if (viewModel.isFileBlockVisible) FileBlock(),
                    ],
                  );
                }),
              ),
            ),
            Listener(
              onPointerDown: (event) =>
                  viewModel.onTypePickerPointerDown(event, context),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MediaTypePickerContainer(),
              ),
            ),
            if (viewModel.isTextEditorPanelVisible)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: AppColors.darkestGray,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: quill.QuillToolbar.basic(
                    controller: viewModel.textEditorController,
                    showBoldButton: true,
                    showItalicButton: true,
                    showSmallButton: false,
                    showUnderLineButton: true,
                    showStrikeThrough: true,
                    showInlineCode: false,
                    showColorButton: false,
                    showBackgroundColorButton: false,
                    showClearFormat: true,
                    showAlignmentButtons: false,
                    showHeaderStyle: true,
                    showListNumbers: true,
                    showListBullets: true,
                    showListCheck: false,
                    showCodeBlock: false,
                    showQuote: true,
                    showIndent: false,
                    showLink: false,
                    showHistory: true,
                    showHorizontalRule: false,
                    multiRowsDisplay: false,
                    showImageButton: false,
                    showVideoButton: false,
                    showCameraButton: false,
                  ),
                ),
              ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_blocks.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_header_widget.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_like_widget.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/widgets/simple_viewer.dart';
import 'package:stacked/stacked.dart';

class PublicationPreviewWidget extends ViewModelWidget<PublicationViewModel> {
  const PublicationPreviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    if (!viewModel.isDataReady()) {
      return SizedBox.shrink();
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: viewModel.onPublicationPreviewClicked,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublicationHeaderWidget(),
          if (viewModel.publication!.mediaUrls.isNotEmpty)
            IgnorePointer(child: MediaBlock()),
          _PublicationPreviewTextWidget(),
          _PublicationPreviewFooterWidget(),
        ],
      ),
    );
  }
}

class _PublicationPreviewTextWidget
    extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    if (viewModel.textController == null ||
        viewModel.textController!.document.isEmpty()) {
      return SizedBox.shrink();
    }
    if (viewModel.previewTextHeight == null) {
      viewModel.calcPreviewTextHeight();
    }
    bool hasOverflow = (viewModel.previewTextHeight != null &&
        viewModel.previewTextHeight! >=
            PublicationViewModel.maxPreviewTextHeight);
    Widget child = Container(
      key: viewModel.previewTextStickyKey,
      constraints:
          BoxConstraints(maxHeight: PublicationViewModel.maxPreviewTextHeight),
      child: QuillSimpleViewer(
        controller: viewModel.textController!,
        readOnly: true,
        truncate: true,
        customStyles: getPublicationTextStyle(context),
      ),
    );
    return Padding(
      padding: EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          (hasOverflow)
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.transparent,
                        AppColors.white.withOpacity(0.05),
                        AppColors.white.withOpacity(0.6),
                        AppColors.white.withOpacity(1),
                      ],
                      stops: [0.0, 0.1, 0.3, 0.4],
                    ).createShader(bounds);
                  },
                  child: child,
                )
              : child,
          if (hasOverflow)
            Align(
              alignment: Alignment.bottomCenter,
              child: Icon(Icons.keyboard_arrow_down),
            ),
        ],
      ),
    );
  }
}

class _PublicationPreviewFooterWidget
    extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) =>
      SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PublicationLikeWidget(),
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  if (viewModel.publication!.link != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.link,
                        color: AppColors.lightestAccentColor,
                        size: 16,
                      ),
                    ),
                  if (viewModel.publication!.attachedFileUrl != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.attach_file,
                        color: AppColors.lightestAccentColor,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}

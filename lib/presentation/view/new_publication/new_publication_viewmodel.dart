import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media.dart'
    as picker_media;
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media_picker.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validators/validators.dart';
import 'package:video_compress/video_compress.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  static const int maxMediaSize = 9;
  static const double maxAttachedFileSizeInMb = 5;
  final Hub hub;
  final CarouselController buttonCarouselController = CarouselController();
  final quill.QuillController textEditorController =
      quill.QuillController.basic();
  final FocusNode textBlockFocusNode = FocusNode();
  final FocusNode linkBlockFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  MediaViewType mediaViewType = MediaViewType.values[0];
  int currentMediaCarouselIndex = 0;
  int mediaViewTypeIndex = 0;
  bool isTypePickerCollapsed = false;
  bool isMediaBlockVisible = false;
  bool isTextBlockVisible = false;
  bool isLinkBlockVisible = false;
  bool isFileBlockVisible = false;
  bool isTextEditorPanelVisible = false;

  NewPublicationViewModel(this.hub) {
    textBlockFocusNode.addListener(() {
      isTextEditorPanelVisible = textBlockFocusNode.hasFocus;
      notifyListeners();
    });
  }

  final NavigationService _navigationService = locator<NavigationService>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();

  final NewPublicationViewData viewData = NewPublicationViewData();
  final TextEditingController publicationLinkController =
      TextEditingController(text: 'https://');

  void onDonePressed() async {
    if (isLinkBlockVisible && !isLinkValid()) {
      AppSnackBar.showSnackBarError(Strings.invalidLink);
      return;
    }
    if (!isPublicationContentValid()) {
      AppSnackBar.showSnackBarError(Strings.errorPublicationCannotBeEmpty);
      return;
    }

    final text = (isTextBlockVisible &&
            textEditorController.document.toPlainText().isNotEmpty)
        ? jsonEncode(textEditorController.document.toDelta().toJson())
        : null;
    final link = (isLinkBlockVisible && isLinkValid())
        ? publicationLinkController.text
        : null;

    final attachedFileUrl =
        (isFileBlockVisible) ? viewData.attachedFile!.path : null;
    final mediaFiles =
        (isMediaBlockVisible) ? viewData.mediaFiles : <LocalMediaFile>[];

    _publicationRepository.createPublication(
      hubId: hub.id,
      text: text,
      link: link,
      attachedFileUrl: attachedFileUrl,
      mediaFiles: mediaFiles,
      viewType: mediaViewType,
    );

    _navigationService.back(result: true);
  }

  bool isPublicationContentValid() {
    return viewData.mediaFiles.isNotEmpty ||
        textEditorController.document.toPlainText().isNotEmpty;
  }

  bool isLinkValid() =>
      isURL(publicationLinkController.text, requireProtocol: true);

  void onMediaViewTypeIndexChanged(int index) {
    mediaViewTypeIndex = index;
    mediaViewType = MediaViewType.values[index];
    notifyListeners();
  }

  void updateMediaList(List<picker_media.Media> pickerMedia) async {
    viewData.mediaFiles = [];

    if (!isMediaBlockVisible) isMediaBlockVisible = true;
    isTypePickerCollapsed = true;

    for (picker_media.Media media in pickerMedia) {
      File previewImage;
      if (media.mediaType == PickerMediaType.image)
        previewImage = await compressImage(media.file!.path, 25);
      else if (media.mediaType == PickerMediaType.video)
        previewImage = await _getVideoThumbnail(media.file!.path);
      else {
        throw ArgumentError();
      }

      LocalMediaFile mediaFile = LocalMediaFile(
          id: media.id,
          originalFile: media.file!,
          previewImage: previewImage,
          type: media.mediaType!.toPubMediaType());

      viewData.mediaFiles.add(mediaFile);
      notifyListeners();
    }
  }

  Future<File> _getVideoThumbnail(String path) =>
      VideoCompress.getFileThumbnail(path);

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    currentMediaCarouselIndex = index;
    notifyListeners();
  }

  void removeMedia(int position) {
    viewData.mediaFiles.removeAt(position);
    if (currentMediaCarouselIndex > viewData.mediaFiles.length - 1 &&
        currentMediaCarouselIndex > 0) {
      currentMediaCarouselIndex = viewData.mediaFiles.length - 1;
    }
    if (viewData.mediaFiles.length == 0) {
      currentMediaCarouselIndex = 0;
      isMediaBlockVisible = false;
    }
    notifyListeners();
  }

  void _openMediaPicker(
      BuildContext context, PickerMediaType mediaType, MediaCount mediaCount) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MediaPicker(
            mediaList:
                viewData.mediaFiles.map((e) => e.toPickerMedia()).toList(),
            onPick: (selectedList) {
              if (selectedList.length > NewPublicationViewModel.maxMediaSize) {
                AppSnackBar.showSnackBarError(Strings.errorLimitMaxMediaSize);
                return;
              }
              updateMediaList(selectedList);
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            mediaCount: mediaCount,
            mediaType: mediaType,
          );
        });
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile platformFile = result.files.single;

      if (platformFile.size > maxAttachedFileSizeInMb * 1024 * 1024) {
        AppSnackBar.showSnackBarError(Strings.fileSizeLimitExceeded);
      } else {
        viewData.attachedFile = platformFile;
        if (!isFileBlockVisible) isFileBlockVisible = true;
        isTypePickerCollapsed = true;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    textEditorController.dispose();
    publicationLinkController.dispose();
    textBlockFocusNode.dispose();
    linkBlockFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  onGalleryMediaItemPicked(BuildContext context) {
    if (isMediaBlockVisible) {
      isMediaBlockVisible = false;
      if (!isAnyBlockVisible()) {
        isTypePickerCollapsed = false;
      }
      notifyListeners();
    } else {
      _openMediaPicker(context, PickerMediaType.common, MediaCount.multiple);
    }
  }

  onAudioMediaItemPicked(BuildContext context) {
    // _openMediaPicker(context, PickerMediaType.audio, MediaCount.single);
  }

  onTextMediaItemPicked() {
    isTextBlockVisible = !isTextBlockVisible;
    if (isTextBlockVisible) textBlockFocusNode.requestFocus();

    if (isTextBlockVisible) {
      isTypePickerCollapsed = true;
    } else {
      textBlockFocusNode.unfocus();
      if (!isAnyBlockVisible()) {
        isTypePickerCollapsed = false;
      }
    }

    notifyListeners();
  }

  onLinkMediaItemPicked() {
    isLinkBlockVisible = !isLinkBlockVisible;
    if (isLinkBlockVisible) linkBlockFocusNode.requestFocus();

    if (isLinkBlockVisible) {
      isTypePickerCollapsed = true;
    } else {
      linkBlockFocusNode.unfocus();
      if (!isAnyBlockVisible()) {
        isTypePickerCollapsed = false;
      }
    }

    notifyListeners();
  }

  onFileMediaItemPicked() {
    if (isFileBlockVisible) {
      isFileBlockVisible = false;
      if (!isAnyBlockVisible()) {
        isTypePickerCollapsed = false;
      }
      notifyListeners();
    } else {
      _openFilePicker();
    }
  }

  bool isAnyBlockVisible() =>
      isMediaBlockVisible ||
      isTextBlockVisible ||
      isLinkBlockVisible ||
      isFileBlockVisible;
}

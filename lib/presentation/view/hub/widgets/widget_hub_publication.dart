import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/base/widget_like.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class WidgetHubPublication extends StatelessWidget {
  final User? user;
  final Hub? hub;
  final Publication publication;
  final Function(String publicationId, bool isLiked) onPublicationLikeClicked;
  final Function(String publicationId) onUsersLikedScreenClicked;
  final Function(Publication publication) onPublicationDetailsClicked;
  final Function(User? user) onUserClicked;
  final Function(Hub? hub) onHubClicked;
  final Function(Publication publication) onReport;
  final quill.QuillController textController;

  const WidgetHubPublication({
    Key? key,
    required this.user,
    required this.hub,
    required this.publication,
    required this.onPublicationLikeClicked,
    required this.onUsersLikedScreenClicked,
    required this.onPublicationDetailsClicked,
    required this.onReport,
    required this.onUserClicked,
    required this.onHubClicked,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onPublicationDetailsClicked(publication),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          WidgetProfilePhoto(
                            photoUrl: user?.photoURL,
                            radius: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            user?.name ?? user?.username ?? user?.email ?? '',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => onUserClicked(user),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(Strings.inWord,
                          style: TextStyle(color: AppColors.white)),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          WidgetHubPhoto(
                            photoUrl: hub?.pictureUrl,
                            radius: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            hub?.name ?? '',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => onHubClicked(hub),
                    ),
                  ],
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.white,
                    ),
                  ),
                  onTap: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          OptionsBottomSheet(() => onReport(publication))),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
            ),
            IgnorePointer(
              child: _WidgetHubPublicationMedia(
                publication.mediaUrls,
                publication.previewUrls,
                publication.viewType,
                key: UniqueKey(),
              ),
            ),
            _WidgetHubPublicationText(
              textController,
              key: UniqueKey(),
            ),
            _WidgetHubPublicationFooter(
              publication: publication,
              onPublicationLikeClicked: onPublicationLikeClicked,
              onUsersLikedScreenClicked: () =>
                  onUsersLikedScreenClicked(publication.id),
              key: UniqueKey(),
            ),
          ],
        ),
      );
}

class _WidgetHubPublicationText extends StatelessWidget {
  final quill.QuillController textController;

  const _WidgetHubPublicationText(this.textController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: quill.QuillEditor.basic(
          controller: textController,
          readOnly: true,
        ),
      );
}

class _WidgetHubPublicationMedia extends StatelessWidget {
  final List<String> mediaUrls;
  final List<String> previewUrls;
  final MediaViewType viewType;

  const _WidgetHubPublicationMedia(
      this.mediaUrls, this.previewUrls, this.viewType,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mediaUrls.isEmpty) return SizedBox.shrink();

    List<RemoteMediaFile> mediaFiles = [];
    for (int i = 0; i < mediaUrls.length; i++) {
      String mediaUrl = mediaUrls[i];
      switch (getUrlType(mediaUrl)) {
        case UrlType.IMAGE:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: previewUrls[i],
            type: MediaType.image,
          ));
          break;
        case UrlType.VIDEO:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: previewUrls[i],
            type: MediaType.video,
          ));
          break;
        case UrlType.UNKNOWN:
          throw ArgumentError(Strings.unknownMediaType);
      }
    }

    if (viewType == MediaViewType.carousel) {
      return WidgetPublicationMediaCarouselPreview(mediaFiles);
    } else if (viewType == MediaViewType.grid) {
      return WidgetPublicationMediaGridPreview(mediaFiles);
    } else {
      throw ArgumentError(Strings.unknownMediaType);
    }
  }
}

class _WidgetHubPublicationFooter extends StatelessWidget {
  final Publication publication;
  final Function(String, bool) onPublicationLikeClicked;
  final Function onUsersLikedScreenClicked;

  const _WidgetHubPublicationFooter({
    required this.publication,
    required this.onPublicationLikeClicked,
    required this.onUsersLikedScreenClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                WidgetLike(
                  publication.isLiked,
                  publication.likesCount,
                  onPublicationLikeClicked: (isLiked) =>
                      onPublicationLikeClicked(
                    publication.id,
                    isLiked,
                  ),
                  onUsersLikedScreenClicked: onUsersLikedScreenClicked,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                ),
                Icon(
                  Icons.messenger_outline,
                  color: AppColors.white,
                ),
              ],
            ),
            Row(
              children: [
                if (publication.mediaUrls.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      Icons.photo,
                      color: AppColors.lightestAccentColor,
                      size: 16,
                    ),
                  ),
                if (publication.text != null && publication.text!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      Icons.text_fields,
                      color: AppColors.lightestAccentColor,
                      size: 16,
                    ),
                  ),
                if (publication.link != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      Icons.link,
                      color: AppColors.lightestAccentColor,
                      size: 16,
                    ),
                  ),
                if (publication.attachedFileUrl != null)
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
          ],
        ),
      );
}

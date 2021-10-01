import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/base/widget_like.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                            width: 28,
                            height: 28,
                          ),
                          SizedBox(width: 4),
                          Text(
                            user?.name ?? user?.username ?? user?.email ?? '',
                            style: TextStyle(
                              color: AppColors.black,
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
                      child: Text(Strings.inWord),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          WidgetProfilePhoto(
                            photoUrl: hub?.pictureUrl,
                            width: 28,
                            height: 28,
                          ),
                          SizedBox(width: 4),
                          Text(
                            hub?.name ?? '',
                            style: TextStyle(
                              color: AppColors.black,
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
                    child: Icon(Icons.more_vert),
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
            _WidgetHubPublicationMedia(
              publication.mediaUrls,
              publication.previewUrls,
              publication.viewType,
              key: UniqueKey(),
            ),
            _WidgetHubPublicationText(
              publication.text,
              key: UniqueKey(),
            ),
            _WidgetHubPublicationFooter(
              publicationId: publication.id,
              isLiked: publication.isLiked,
              likesCount: publication.likesCount,
              commentsCount: publication.commentsCount,
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
  final String? text;

  const _WidgetHubPublicationText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => text != null && text!.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Text(
            text!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        )
      : SizedBox.shrink();
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
  final String publicationId;
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final Function(String, bool) onPublicationLikeClicked;
  final Function onUsersLikedScreenClicked;

  const _WidgetHubPublicationFooter({
    required this.publicationId,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.onPublicationLikeClicked,
    required this.onUsersLikedScreenClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Row(
          children: [
            WidgetLike(
              isLiked,
              likesCount,
              onPublicationLikeClicked: (isLiked) => onPublicationLikeClicked(
                publicationId,
                isLiked,
              ),
              onUsersLikedScreenClicked: onUsersLikedScreenClicked,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
            ),
            Icon(
              Icons.messenger_outline,
              color: AppColors.black,
            ),
          ],
        ),
      );
}

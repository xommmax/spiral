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
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/widgets/simple_viewer.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
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
            ),
            IgnorePointer(
              child: _WidgetHubPublicationMedia(
                publication.mediaUrls,
                publication.previewUrls,
                publication.viewType,
              ),
            ),
            _WidgetHubPublicationText(
              textController,
            ),
            _WidgetHubPublicationFooter(
              publication: publication,
              onPublicationLikeClicked: onPublicationLikeClicked,
              onUsersLikedScreenClicked: () =>
                  onUsersLikedScreenClicked(publication.id),
            ),
          ],
        ),
      );
}

class _WidgetHubPublicationText extends StatefulWidget {
  final quill.QuillController textController;

  _WidgetHubPublicationText(this.textController, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WidgetHubPublicationTextState();
}

class _WidgetHubPublicationTextState extends State<_WidgetHubPublicationText> {
  static const double maxTextHeight = 300;
  final GlobalKey stickyKey = GlobalKey();
  double? textHeight;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      var tempHeight = stickyKey.currentContext?.size?.height;
      if (textHeight != tempHeight) {
        setState(() => textHeight = tempHeight);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasOverflow = (textHeight != null && textHeight! >= maxTextHeight);
    Widget child = Container(
      key: stickyKey,
      constraints: BoxConstraints(maxHeight: maxTextHeight),
      child: QuillSimpleViewer(
        controller: widget.textController,
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
                      stops: [
                        0.0,
                        0.1,
                        0.3,
                        0.4,
                      ],
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

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Builder(
        builder: (context) {
          if (viewType == MediaViewType.carousel) {
            return WidgetPublicationMediaCarouselPreview(mediaFiles);
          } else if (viewType == MediaViewType.grid) {
            return WidgetPublicationMediaGridPreview(mediaFiles);
          } else {
            throw ArgumentError(Strings.unknownMediaType);
          }
        },
      ),
    );
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
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Row(
                children: [
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
            ),
          ],
        ),
      );
}

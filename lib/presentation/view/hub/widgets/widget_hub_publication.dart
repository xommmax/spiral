import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/widget_like.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication_media.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHubPublication extends StatelessWidget {
  final User user;
  final Publication publication;
  final Function(String publicationId, bool isLiked) onPublicationLikeClicked;

  const WidgetHubPublication({
    Key? key,
    required this.user,
    required this.publication,
    required this.onPublicationLikeClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WidgetHubPublicationHeader(
            user,
            key: UniqueKey(),
          ),
          _WidgetHubPublicationText(
            publication.text,
            key: UniqueKey(),
          ),
          _WidgetHubPublicationMedia(
            publication.mediaUrls,
            key: UniqueKey(),
          ),
          _WidgetHubPublicationFooter(
            publication.id,
            onPublicationLikeClicked,
            key: UniqueKey(),
          ),
        ],
      );
}

class _WidgetHubPublicationHeader extends StatelessWidget {
  final User user;

  const _WidgetHubPublicationHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              WidgetProfilePhoto(
                photoUrl: user.photoURL,
                width: 22,
                height: 22,
              ),
              Expanded(
                child: Text(
                  user.displayName ?? '',
                  style: TextStyles.robotoBlack12,
                ),
              ),
            ],
          ),
        ),
      );
}

class _WidgetHubPublicationText extends StatelessWidget {
  final String? text;

  const _WidgetHubPublicationText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => text != null && text!.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text!),
          ),
        )
      : SizedBox.shrink();
}

class _WidgetHubPublicationMedia extends StatelessWidget {
  final List<String> mediaUrls;

  const _WidgetHubPublicationMedia(this.mediaUrls, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => mediaUrls.isNotEmpty
      ? SizedBox(
          height: 160,
          child: WidgetHubPublicationMedia(mediaUrls),
        )
      : SizedBox.shrink();
}

class _WidgetHubPublicationFooter extends StatelessWidget {
  final Function(String, bool) onPublicationLikeClicked;
  final String publicationId;

  const _WidgetHubPublicationFooter(
      this.publicationId, this.onPublicationLikeClicked,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Row(
          children: [
            WidgetLike(
              (isLiked) => onPublicationLikeClicked(
                publicationId,
                isLiked,
              ),
              false,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
            ),
            Icon(
              Icons.messenger,
              color: AppColors.black,
            )
          ],
        ),
      );
}

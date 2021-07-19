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
  Widget build(BuildContext context) => Container(
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            publication.text != null && publication.text!.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(publication.text!),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: WidgetHubPublicationMedia(publication.mediaUrls),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  WidgetLike(
                    (isLiked) => onPublicationLikeClicked(
                      publication.id,
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
            ),
          ],
        ),
      );
}

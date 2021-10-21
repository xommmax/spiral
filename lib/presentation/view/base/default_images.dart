import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class WidgetHubPhoto extends StatelessWidget {
  final String? photoUrl;
  final double radius;

  WidgetHubPhoto({this.photoUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) return DefaultHubImage(radius: radius);

    return Container(
      width: 2 * radius,
      height: 2 * radius,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(photoUrl!),
        ),
      ),
    );
  }
}

class DefaultHubImage extends StatelessWidget {
  final double radius;

  DefaultHubImage({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assets/images/default_hub_cover.png').image),
      ),
    );
  }
}

class WidgetProfilePhoto extends StatelessWidget {
  final String? photoUrl;
  final double radius;

  WidgetProfilePhoto({this.photoUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) return DefaultProfileImage(radius: radius);

    return Container(
      width: 2 * radius,
      height: 2 * radius,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(photoUrl!),
        ),
      ),
    );
  }
}

class DefaultProfileImage extends StatelessWidget {
  final double radius;

  DefaultProfileImage({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.cover,
            image:
                Image.asset('assets/images/default_profile_cover.png').image),
      ),
    );
  }
}

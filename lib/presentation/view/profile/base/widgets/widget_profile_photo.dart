import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:flutter/material.dart';

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

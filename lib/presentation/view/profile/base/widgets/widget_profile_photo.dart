import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetProfilePhoto extends StatelessWidget {
  final String? photoUrl;
  final double? width;
  final double? height;

  WidgetProfilePhoto({this.photoUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) return Icon(Icons.person);

    return Container(
      width: width,
      height: height,
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

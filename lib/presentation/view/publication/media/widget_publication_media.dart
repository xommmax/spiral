import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/view/base/full_screen_publication_media_widget.dart';
import 'package:dairo/presentation/view/base/widget_video_preview.dart';
import 'package:flutter/material.dart';

class WidgetPublicationMediaPreview extends StatelessWidget {
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final bool local;

  WidgetPublicationMediaPreview(this.mediaFiles, this.currentIndex,
      {this.local = false});

  @override
  Widget build(BuildContext context) {
    final file = mediaFiles[currentIndex];
    return FullScreenPublicationMediaWidget(
      child: ClipRRect(
        child: file.type == MediaType.image
            ? local
                ? Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: file.path,
                    fit: BoxFit.cover,
                  )
            : WidgetVideoPreview(filePath: file.path),
      ),
      mediaFiles: mediaFiles,
      currentIndex: currentIndex,
      local: local,
    );
  }
}

class WidgetPublicationMedia extends StatelessWidget {
  final List<MediaFile> mediaFiles;

  WidgetPublicationMedia(this.mediaFiles);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: mediaFiles
          .map((file) => CachedNetworkImage(imageUrl: file.path))
          .toList(),
    );
  }
}

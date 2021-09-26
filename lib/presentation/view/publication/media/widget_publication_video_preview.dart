import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class WidgetPublicationVideoPreview extends StatefulWidget {
  final String? filePath;
  final String? networkUrl;
  final BoxFit? fit;
  final bool isPlayable;

  WidgetPublicationVideoPreview(
      {this.filePath, this.networkUrl, this.fit, this.isPlayable = false});

  @override
  State<StatefulWidget> createState() => WidgetPublicationVideoPreviewState();
}

class WidgetPublicationVideoPreviewState
    extends State<WidgetPublicationVideoPreview> {
  String? thumbnail;

  @override
  void initState() {
    super.initState();
    if (widget.filePath != null)
      _getThumbnail(widget.filePath!);
    else if (widget.networkUrl != null)
      _getThumbnail(widget.networkUrl!);
    else
      throw ArgumentError();
  }

  void _getThumbnail(String path) async {
    VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 40,
    ).then((value) => setState(() => thumbnail = value));
  }

  @override
  Widget build(BuildContext context) {
    if (thumbnail == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(thumbnail!),
            fit: widget.fit,
          ),
          Align(
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Color(0x80000000),
              child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: AppColors.white,
                  ),
                  onPressed: widget.isPlayable
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetPublicationVideo(
                                      filePath: widget.filePath,
                                      networkUrl: widget.networkUrl,
                                    )),
                          );
                        }
                      : null),
            ),
          ),
        ],
      );
    }
  }
}

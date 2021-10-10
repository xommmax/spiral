import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class WidgetPublicationVideo extends StatefulWidget {
  final String? filePath;
  final String? networkUrl;

  const WidgetPublicationVideo({
    this.filePath,
    this.networkUrl,
  });

  @override
  _WidgetVideoPreviewState createState() => _WidgetVideoPreviewState();
}

class _WidgetVideoPreviewState extends State<WidgetPublicationVideo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  Future<void> _initVideoController() async {
    if (widget.filePath != null) {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.filePath!));
    }
    if (widget.networkUrl != null) {
      _videoPlayerController =
          VideoPlayerController.network(widget.networkUrl!);
    }
    if (_videoPlayerController != null) {
      await _videoPlayerController!.initialize();
      chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
      );
      setState(() => _isInitialized = true);
    } else {
      throw Exception(
          'Video Controller is null, \'filePath\' or \'networkUrl\' property must not be null');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                  child: _isInitialized &&
                          chewieController != null &&
                          chewieController!
                              .videoPlayerController.value.isInitialized
                      ? Chewie(
                          controller: chewieController!,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        )),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}

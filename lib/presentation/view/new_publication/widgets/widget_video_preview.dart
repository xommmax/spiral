import 'dart:io';

import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class WidgetVideoPreview extends StatefulWidget {
  final String filePath;

  const WidgetVideoPreview(this.filePath, {Key? key}) : super(key: key);

  @override
  _WidgetVideoPreviewState createState() => _WidgetVideoPreviewState();
}

class _WidgetVideoPreviewState extends State<WidgetVideoPreview> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) => setState(() => _isInitialized = true))
      ..play()
      ..setVolume(0.0)
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) => _isInitialized
      ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: _controller!.value.size.height,
            width: _controller!.value.size.width,
            child: VideoPlayer(_controller!),
          ),
        )
      : Center(child: ProgressBar());

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

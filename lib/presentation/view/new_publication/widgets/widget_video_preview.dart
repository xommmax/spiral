import 'dart:io';

import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class WidgetVideoPreview extends StatefulWidget {
  final String? filePath;
  final String? networkUrl;

  const WidgetVideoPreview({
    this.filePath,
    this.networkUrl,
  });

  @override
  _WidgetVideoPreviewState createState() => _WidgetVideoPreviewState();
}

class _WidgetVideoPreviewState extends State<WidgetVideoPreview> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  Future<void> _initVideoController() async {
    if (widget.filePath != null) {
      _controller = VideoPlayerController.file(File(widget.filePath!));
    }
    if (widget.networkUrl != null) {
      _controller = VideoPlayerController.network(widget.networkUrl!);
    }
    if (_controller != null) {
      await _controller
          ?.initialize()
          .then((_) => setState(() => _isInitialized = true));
      _controller?.play();
      _controller?.setVolume(0.0);
      _controller?.setLooping(true);
    } else {
      throw Exception(
          'Video Controller is null, \'filePath\' or \'networkUrl\' property must not be null');
    }
  }

  @override
  Widget build(BuildContext context) => _isInitialized
      ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: _controller?.value.size.height,
            width: _controller?.value.size.width,
            child: VideoPlayer(_controller!),
          ),
        )
      : Center(
          child: ProgressBar(),
        );

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

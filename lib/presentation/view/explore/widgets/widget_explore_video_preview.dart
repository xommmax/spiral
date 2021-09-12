import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class WidgetExploreVideoPreview extends StatefulWidget {
  final String? networkUrl;

  const WidgetExploreVideoPreview({this.networkUrl});

  @override
  _WidgetExploreVideoPreviewState createState() =>
      _WidgetExploreVideoPreviewState();
}

class _WidgetExploreVideoPreviewState extends State<WidgetExploreVideoPreview> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  Future<void> _initVideoController() async {
    final videoOptions = VideoPlayerOptions(mixWithOthers: true);
    _controller = VideoPlayerController.network(widget.networkUrl!,
        videoPlayerOptions: videoOptions);
    await _controller
        ?.initialize()
        .then((_) => setState(() => _isInitialized = true));

    _controller?.setVolume(0.0);
    _controller?.setLooping(true);
    // _controller?.play();
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
      : SizedBox.shrink();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

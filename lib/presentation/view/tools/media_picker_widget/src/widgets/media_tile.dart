import 'dart:ui';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../media.dart';
import '../picker_decoration.dart';

class MediaTile extends StatefulWidget {
  MediaTile({
    Key? key,
    required this.media,
    required this.onSelected,
    this.isSelected = false,
    this.decoration,
  }) : super(key: key);

  final AssetEntity media;
  final Function(bool, Media) onSelected;
  final bool isSelected;
  final PickerDecoration? decoration;

  @override
  _MediaTileState createState() => _MediaTileState();
}

class _MediaTileState extends State<MediaTile>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  bool? selected;

  Media? media;

  Duration _duration = Duration(milliseconds: 100);
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animation =
        Tween<double>(begin: 1.0, end: 1.3).animate(_animationController!);
    selected = widget.isSelected;
    if (selected!) _animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (media != null) {
      return Padding(
        padding: const EdgeInsets.all(0.5),
        child: Stack(
          children: [
            Positioned.fill(
              child: InkWell(
                onTap: () {
                  setState(() => selected = !selected!);
                  if (selected!)
                    _animationController!.forward();
                  else
                    _animationController!.reverse();
                  widget.onSelected(selected!, media!);
                },
                child: getTileItem(),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _SelectedItemLabel(_duration, selected!),
              ),
            ),
          ],
        ),
      );
    } else {
      Media.fromAssetEntity(media: widget.media)
          .then((_media) => setState(() => media = _media));
      return SizedBox();
    }
  }

  Widget getTileItem() {
    switch (media!.mediaType) {
      case PickerMediaType.image:
        return _ImageItem(
          animation: _animation!,
          media: media!,
          selected: selected!,
          duration: _duration,
          blurStrength: widget.decoration!.blurStrength,
        );
      case PickerMediaType.video:
        return _VideoItem(
          animation: _animation!,
          media: media!,
          selected: selected!,
          duration: _duration,
          blurStrength: widget.decoration!.blurStrength,
        );
      case PickerMediaType.audio:
        return _AudioItem(
          media: media!,
        );
      default:
        throw ArgumentError();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class _ImageItem extends StatelessWidget {
  final Animation animation;
  final Media media;
  final bool selected;
  final Duration duration;
  final double blurStrength;

  _ImageItem({
    required this.animation,
    required this.media,
    required this.selected,
    required this.duration,
    required this.blurStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: animation.value,
                    child: Image.memory(
                      media.thumbnail!,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: selected ? 1 : 0,
            curve: Curves.easeOut,
            duration: duration,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: blurStrength, sigmaY: blurStrength),
                child: Container(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoItem extends StatelessWidget {
  final Animation animation;
  final Media media;
  final bool selected;
  final Duration duration;
  final double blurStrength;

  _VideoItem({
    required this.animation,
    required this.media,
    required this.selected,
    required this.duration,
    required this.blurStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: animation.value,
                    child: Image.memory(
                      media.thumbnail!,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: selected ? 1 : 0,
            curve: Curves.easeOut,
            duration: duration,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: blurStrength, sigmaY: blurStrength),
                child: Container(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 5, bottom: 5),
            child: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _AudioItem extends StatelessWidget {
  final Media media;

  _AudioItem({
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Text(media.title ?? "Empty");
  }
}

class _SelectedItemLabel extends StatelessWidget {
  final Duration _duration;
  final bool _selected;

  _SelectedItemLabel(this._duration, this._selected);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.easeOut,
      duration: _duration,
      opacity: _selected ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkAccentColor, shape: BoxShape.circle),
        padding: const EdgeInsets.all(5),
        child: Icon(
          Icons.done,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/view/base/widget_video_preview.dart';
import 'package:flutter/material.dart';

class FullScreenPublicationMediaWidget extends StatelessWidget {
  FullScreenPublicationMediaWidget({
    required this.child,
    required this.mediaFiles,
    required this.currentIndex,
    required this.local,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.Medium,
  });

  final Widget child;
  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final bool local;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundIsTransparent
                    ? Colors.white.withOpacity(0)
                    : backgroundColor,
                pageBuilder: (BuildContext context, _, __) {
                  return FullScreenPage(
                    mediaFiles: mediaFiles,
                    currentIndex: currentIndex,
                    backgroundColor: backgroundColor,
                    backgroundIsTransparent: backgroundIsTransparent,
                    disposeLevel: disposeLevel,
                    local: local,
                  );
                }));
      },
      child: child,
    );
  }
}

enum DisposeLevel { High, Medium, Low }

class FullScreenPage extends StatefulWidget {
  FullScreenPage({
    required this.mediaFiles,
    required this.currentIndex,
    required this.backgroundColor,
    required this.backgroundIsTransparent,
    required this.disposeLevel,
    required this.local,
  });

  final List<MediaFile> mediaFiles;
  final int currentIndex;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  final bool local;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  double initialPositionY = 0;

  double currentPositionY = 0;

  double positionYDelta = 0;

  double opacity = 1;

  double disposeLimit = 150;

  Duration animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  setDisposeLevel() {
    setState(() {
      if (widget.disposeLevel == DisposeLevel.High)
        disposeLimit = 300;
      else if (widget.disposeLevel == DisposeLevel.Medium)
        disposeLimit = 200;
      else
        disposeLimit = 100;
    });
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY - initialPositionY;
      setOpacity();
    });
  }

  setOpacity() {
    double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 1000) * -1)
        : 1 - (positionYDelta / 1000);
    print(tmp);

    if (tmp > 1)
      opacity = 1;
    else if (tmp < 0)
      opacity = 0;
    else
      opacity = tmp;

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.5;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = Duration(milliseconds: 300);
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_) {
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundIsTransparent
          ? Colors.transparent
          : widget.backgroundColor,
      body: GestureDetector(
        onVerticalDragStart: (details) => _startVerticalDrag(details),
        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        onVerticalDragEnd: (details) => _endVerticalDrag(details),
        child: Container(
          color: widget.backgroundColor.withOpacity(opacity),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.fastOutSlowIn,
                top: 0 + positionYDelta,
                bottom: 0 - positionYDelta,
                left: 0,
                right: 0,
                child: CarouselSlider(
                  items: widget.mediaFiles.map((file) {
                    return file.type == MediaType.image
                        ? widget.local
                            ? Image.file(
                                File(file.path),
                              )
                            : CachedNetworkImage(
                                imageUrl: file.path,
                              )
                        : WidgetVideoPreview(filePath: file.path);
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: widget.currentIndex,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                    disableCenter: true,
                    // onPageChanged: callbackFunction,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHubPreview extends StatelessWidget {
  final Hub _hub;
  static const double paddingLeft = 6;
  static const double paddingTop = 0;
  static const double paddingRight = 6;
  static const double paddingBottom = 0;
  static const int textHeight = 60;

  const WidgetHubPreview(this._hub);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.fromLTRB(
                paddingLeft, paddingTop, paddingRight, paddingBottom),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  getHubImageWidget(_hub),
                  if (_hub.isFollow)
                    Positioned(
                      top: -45,
                      right: -45,
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Container(
                          color: AppColors.accentColor,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  if (_hub.isFollow)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Icon(
                        Icons.check,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  if (_hub.isPrivate)
                    Positioned(
                      bottom: -45,
                      left: -45,
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Container(
                          color: AppColors.black,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  if (_hub.isPrivate)
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Icon(
                        Icons.lock_rounded,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Text(
              _hub.name,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_hub.description != null)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 2, 12, 0),
              child: Text(
                _hub.description!,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
}

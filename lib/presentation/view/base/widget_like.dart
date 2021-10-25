import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetLike extends StatefulWidget {
  final bool _isLiked;
  final int _likesCount;
  final Function(bool) onPublicationLikeClicked;
  final Function onUsersLikedScreenClicked;

  const WidgetLike(
    this._isLiked,
    this._likesCount, {
    required this.onPublicationLikeClicked,
    required this.onUsersLikedScreenClicked,
    Key? key,
  }) : super(key: key);

  @override
  _WidgetLikeState createState() => _WidgetLikeState(_likesCount, _isLiked);
}

class _WidgetLikeState extends State<WidgetLike> {
  bool _isLiked;
  int _likesCount;

  _WidgetLikeState(this._likesCount, this._isLiked);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            onPressed: _onLikeTap,
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              color: AppColors.white,
            ),
          ),
          if (_likesCount != 0)
            InkWell(
              onTap: () => widget.onUsersLikedScreenClicked(),
              child: Text(
                _likesCount.toString() +
                    ((_likesCount == 1) ? ' like' : ' likes'),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      );

  void _setIsLiked(bool isLiked) => setState(() {
        if (!isLiked) {
          if (_likesCount > 0) {
            _likesCount = _likesCount - 1;
          }
        } else {
          _likesCount = _likesCount + 1;
        }
        _isLiked = isLiked;
      });

  void _onLikeTap() {
    _setIsLiked(!_isLiked);
    widget.onPublicationLikeClicked(_isLiked);
  }
}

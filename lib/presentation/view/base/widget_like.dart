import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetLike extends StatefulWidget {
  final Function(bool) onLikeClicked;
  final bool isLiked;

  const WidgetLike(this.onLikeClicked, this.isLiked, {Key? key})
      : super(key: key);

  @override
  _WidgetLikeState createState() => _WidgetLikeState();
}

class _WidgetLikeState extends State<WidgetLike> {
  bool _isLiked = false;

  @override
  void initState() {
    _setIsLiked(widget.isLiked);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _onLikeTap,
        child: Icon(
          _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
          color: AppColors.black,
        ),
      );

  void _setIsLiked(bool isLiked) => setState(() => _isLiked = isLiked);

  void _onLikeTap() {
    _setIsLiked(!_isLiked);
    widget.onLikeClicked(_isLiked);
  }
}

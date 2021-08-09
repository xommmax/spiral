import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetComments extends StatelessWidget {
  final List<Comment> comments;

  const WidgetComments(this.comments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _WidgetCommentListItem(comments[index]),
        separatorBuilder: (context, index) => Divider(height: 10),
        itemCount: comments.length,
      );
}

class _WidgetCommentListItem extends StatelessWidget {
  final Comment comment;

  _WidgetCommentListItem(this.comment);

  @override
  Widget build(BuildContext context) => ListTile(
        key: ValueKey(comment.id),
        leading: SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: comment.user.photoURL != null
                ? CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: comment.user.photoURL!,
                    ),
                  )
                : Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
        title: Text(comment.text),
      );
}

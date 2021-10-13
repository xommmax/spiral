import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetComments extends StatelessWidget {
  final List<Comment> comments;
  final Function(Comment)? setCommentToReply;

  const WidgetComments(
    this.comments, {
    this.setCommentToReply,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => WidgetComment(
          comments[index],
          setCommentToReply: setCommentToReply,
        ),
        separatorBuilder: (context, index) => Divider(height: 10),
        itemCount: comments.length,
      );
}

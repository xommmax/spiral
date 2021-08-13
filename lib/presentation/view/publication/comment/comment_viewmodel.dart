import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';

class CommentViewModel extends BaseViewModel {
  final String publicationId;
  final String parentCommentId;

  CommentViewModel({
    required this.publicationId,
    required this.parentCommentId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  StreamSubscription? _repliesStreamSubscription;
  bool isRepliesShown = false;
  List<Comment>? replies;

  Stream<List<Comment>> get _repliesStream =>
      _publicationRepository.getCommentReplies(
        publicationId: publicationId,
        parentCommentId: parentCommentId,
      );

  void onShowRepliesClicked() {
    isRepliesShown = !isRepliesShown;
    notifyListeners();
    _getCommentReplies();
  }

  void _getCommentReplies() {
    _repliesStreamSubscription = _repliesStream.listen((replies) {
      this.replies = replies;
      notifyListeners();
    });

    _repliesStreamSubscription?.onError((error, stacktrace) {
      print('Replies has error: $error, stacktrace: $stacktrace');
      AppSnackBar.showSnackBarError(Strings.unableToGetRepliesForTheComment);
    });
  }

  void onReplyToThisCommentClicked() {
    if(!isRepliesShown) {
      _getCommentReplies();
    }
  }

  bool areRepliesNotEmpty() => replies != null && replies!.isNotEmpty;

  @override
  void dispose() {
    _repliesStreamSubscription?.cancel();
    super.dispose();
  }
}

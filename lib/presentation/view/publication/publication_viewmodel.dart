import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:dairo/presentation/view/users/users_viewdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PublicationViewModel extends MultipleStreamViewModel {
  static const PUBLICATION_STREAM_KEY = 'PUBLICATION_STREAM_KEY';
  static const COMMENTS_STREAM_KEY = 'COMMENTS_STREAM_KEY';

  final String publicationId;
  final String userId;

  PublicationViewModel({
    required this.publicationId,
    required this.userId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController commentsTextController = TextEditingController();

  Publication? publication;
  List<Comment>? comments;
  Comment? commentToReply;

  @override
  Map<String, StreamData> get streamsMap => {
        PUBLICATION_STREAM_KEY: StreamData<Publication?>(
          publicationStream(),
          onData: _onPublicationRetrieved,
        ),
        COMMENTS_STREAM_KEY: StreamData<List<Comment>?>(
          commentsStream(),
          onData: _onCommentsRetrieved,
        ),
      };

  Stream<Publication?> publicationStream() =>
      _publicationRepository.getPublication(publicationId);

  Stream<List<Comment>?> commentsStream() =>
      _publicationRepository.getComments(publicationId);

  void _onPublicationRetrieved(Publication? publication) =>
      this.publication = publication;

  void _onCommentsRetrieved(List<Comment>? comments) =>
      this.comments = comments;

  @override
  void onError(String key, error) {
    print('Error: $error on key: $key');
    AppSnackBar.showSnackBarError(Strings.unableToGetPublication);
  }

  void onSendCommentClicked() => _publicationRepository
          .sendComment(
        publicationId: publicationId,
        text: commentsTextController.text,
        createAt: DateTime.now().millisecondsSinceEpoch,
        parentCommentId: commentToReply?.id,
      )
          .then(
        (_) {
          commentsTextController.clear();
          setCommentToReply(null);
        },
      );

  bool isDataReady() => publication != null;

  void setCommentToReply(Comment? comment) {
    commentToReply = comment;
    notifyListeners();
  }
}

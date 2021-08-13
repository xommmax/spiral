import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PublicationViewModel extends MultipleStreamViewModel {
  static const PUBLICATION_STREAM_KEY = 'PUBLICATION_STREAM_KEY';
  static const CURRENT_USER_STREAM_KEY = 'CURRENT_USER_STREAM_KEY';
  static const USER_STREAM_KEY = 'USER_STREAM_KEY';
  static const COMMENTS_STREAM_KEY = 'COMMENTS_STREAM_KEY';

  final String publicationId;
  final String userId;

  PublicationViewModel({
    required this.publicationId,
    required this.userId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController commentsTextController = TextEditingController();

  User? user;
  User? currentUser;
  Publication? publication;
  List<Comment>? comments;
  Comment? commentToReply;

  @override
  Map<String, StreamData> get streamsMap => {
        USER_STREAM_KEY: StreamData<User?>(
          userStream(),
          onData: _onUserRetrieved,
        ),
        CURRENT_USER_STREAM_KEY: StreamData<User?>(
          currentUserStream(),
          onData: _onCurrentDataRetrieved,
        ),
        PUBLICATION_STREAM_KEY: StreamData<Publication?>(
          publicationStream(),
          onData: _onPublicationRetrieved,
        ),
        COMMENTS_STREAM_KEY: StreamData<List<Comment>?>(
          commentsStream(),
          onData: _onCommentsRetrieved,
        ),
      };

  Stream<User?> userStream() => _userRepository.getUser(userId);

  Stream<User?> currentUserStream() => _userRepository.getCurrentUser();

  Stream<Publication?> publicationStream() =>
      _publicationRepository.getHubPublication(publicationId);

  Stream<List<Comment>?> commentsStream() =>
      _publicationRepository.getComments(publicationId);

  void _onUserRetrieved(User? user) => this.user = user;

  void _onCurrentDataRetrieved(User? currentUser) =>
      this.currentUser = currentUser;

  void _onPublicationRetrieved(Publication? publication) =>
      this.publication = publication;

  void _onCommentsRetrieved(List<Comment>? comments) =>
      this.comments = comments;

  @override
  void onError(String key, error) {
    print('Error: $error on key: $key');
    AppSnackBar.showSnackBarError(Strings.unableToGetPublication);
  }

  void onPublicationLikeClicked(bool isLiked) =>
      _publicationRepository.sendLike(
        publicationId: publicationId,
        userId: userId,
        isLiked: isLiked,
      );

  void onUsersLikedScreenClicked() async {
    List<String> userIds =
        await _publicationRepository.getUsersLiked(publicationId);
    return _navigationService.navigateTo(
      Routes.usersLikedView,
      arguments: UsersLikedViewArguments(userIds: userIds),
    );
  }

  void onSendCommentClicked() => _publicationRepository
          .sendComment(
        publicationId: publicationId,
        userId: userId,
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

  bool isDataReady() =>
      user != null && currentUser != null && publication != null;

  void setCommentToReply(Comment? comment) {
    commentToReply = comment;
    notifyListeners();
  }
}

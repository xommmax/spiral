import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairo/data/api/firebase_collections.dart';
import 'package:dairo/domain/model/hub/discussion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

/// Provides access to Firebase chat data. Singleton, use
/// FirebaseChatCore.instance to aceess methods.
class FirebaseChatCore {
  FirebaseChatCore._privateConstructor() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      firebaseUser = user;
    });
  }

  /// Config to set custom names for rooms and users collections. Also
  /// see [FirebaseChatCoreConfig].
  FirebaseChatCoreConfig config = const FirebaseChatCoreConfig(
    FirebaseCollections.hubDiscussions,
    FirebaseCollections.users,
  );

  /// Current logged in user in Firebase. Does not update automatically.
  /// Use [FirebaseAuth.authStateChanges] to listen to the state changes.
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  /// Singleton instance
  static final FirebaseChatCore instance =
      FirebaseChatCore._privateConstructor();

  /// Sets custom config to change default names for rooms
  /// and users collections. Also see [FirebaseChatCoreConfig].
  void setConfig(FirebaseChatCoreConfig firebaseChatCoreConfig) {
    config = firebaseChatCoreConfig;
  }

  /// Returns a stream of messages from Firebase for a given room
  Stream<List<types.Message>> messages(HubDiscussion discussion) {
    return FirebaseFirestore.instance
        .collection('${config.roomsCollectionName}/${discussion.id}/messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final data = doc.data();
            final author = types.User(id: data['authorId'] as String);
            data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
            data['id'] = doc.id;
            data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

            return data;
          },
        ).toList();
      },
    ).asyncMap((jsonList) => convertJsonListToMessageList(jsonList));
  }

  Future<List<types.Message>> convertJsonListToMessageList(
      List<Map<String, dynamic>> jsonList) async {
    List<types.Message> messages = [];
    for (int i = 0; i < jsonList.length; i++) {
      messages.add(await convertJsonToMessage(jsonList[i]));
    }
    return messages;
  }

  Future<types.Message> convertJsonToMessage(Map<String, dynamic> data) async {
    types.User user = await FirebaseFirestore.instance
        .doc('${FirebaseCollections.users}/${data['authorId']}')
        .get()
        .then((snapshot) => types.User(
              id: snapshot.id,
              firstName: snapshot.data()!['name'],
              imageUrl: snapshot.data()!['photoURL'],
            ));

    data['author'] = user.toJson();
    return types.Message.fromJson(data);
  }

  /// Returns a stream of changes in a room from Firebase
  Stream<HubDiscussion> discussion(String discussionId) {
    final fu = firebaseUser;

    if (fu == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection(config.roomsCollectionName)
        .doc(discussionId)
        .snapshots()
        .asyncMap(
          (doc) => HubDiscussion.fromJson(doc.data()!, doc.id),
        );
  }

  /// Sends a message to the Firestore. Accepts any partial message and a
  /// room ID. If arbitraty data is provided in the [partialMessage]
  /// does nothing.
  void sendMessage(dynamic partialMessage, String roomId) async {
    if (firebaseUser == null) return;

    types.Message? message;

    if (partialMessage is types.PartialCustom) {
      message = types.CustomMessage.fromPartial(
        author: types.User(id: firebaseUser!.uid),
        id: '',
        partialCustom: partialMessage,
      );
    } else if (partialMessage is types.PartialFile) {
      message = types.FileMessage.fromPartial(
        author: types.User(id: firebaseUser!.uid),
        id: '',
        partialFile: partialMessage,
      );
    } else if (partialMessage is types.PartialImage) {
      message = types.ImageMessage.fromPartial(
        author: types.User(id: firebaseUser!.uid),
        id: '',
        partialImage: partialMessage,
      );
    } else if (partialMessage is types.PartialText) {
      message = types.TextMessage.fromPartial(
        author: types.User(id: firebaseUser!.uid),
        id: '',
        partialText: partialMessage,
      );
    }

    if (message != null) {
      final messageMap = message.toJson();
      messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
      messageMap['authorId'] = firebaseUser!.uid;
      messageMap['createdAt'] = FieldValue.serverTimestamp();
      messageMap['updatedAt'] = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection('${config.roomsCollectionName}/$roomId/messages')
          .add(messageMap);
    }
  }

  /// Updates a message in the Firestore. Accepts any message and a
  /// room ID. Message will probably be taken from the [messages] stream.
  void updateMessage(types.Message message, String roomId) async {
    if (firebaseUser == null) return;
    if (message.author.id != firebaseUser!.uid) return;

    final messageMap = message.toJson();
    messageMap.removeWhere(
        (key, value) => key == 'author' || key == 'createdAt' || key == 'id');
    messageMap['authorId'] = message.author.id;
    messageMap['updatedAt'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance
        .collection('${config.roomsCollectionName}/$roomId/messages')
        .doc(message.id)
        .update(messageMap);
  }

  /// Returns a stream of all users from Firebase
  Stream<List<types.User>> users() {
    if (firebaseUser == null) return const Stream.empty();
    return FirebaseFirestore.instance
        .collection(config.usersCollectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<types.User>>(
            [],
            (previousValue, doc) {
              if (firebaseUser!.uid == doc.id) return previousValue;

              final data = doc.data();

              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, types.User.fromJson(data)];
            },
          ),
        );
  }
}

class FirebaseChatCoreConfig {
  const FirebaseChatCoreConfig(
    this.roomsCollectionName,
    this.usersCollectionName,
  );

  /// Property to set rooms collection name
  final String roomsCollectionName;

  /// Property to set users collection name
  final String usersCollectionName;
}

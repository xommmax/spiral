// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dairo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDairoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DairoDatabaseBuilder databaseBuilder(String name) =>
      _$DairoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DairoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DairoDatabaseBuilder(null);
}

class _$DairoDatabaseBuilder {
  _$DairoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DairoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DairoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DairoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DairoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DairoDatabase extends DairoDatabase {
  _$DairoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  HubDao? _hubDaoInstance;

  PublicationDao? _publicationDaoInstance;

  CommentDao? _commentDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT NOT NULL, `name` TEXT, `username` TEXT, `description` TEXT, `email` TEXT, `phoneNumber` TEXT, `photoURL` TEXT, `followingsCount` INTEGER, `age` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hub` (`id` TEXT NOT NULL, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT, `pictureUrl` TEXT, `createdAt` INTEGER NOT NULL, `followersCount` INTEGER NOT NULL, `isFollow` INTEGER NOT NULL, `isPrivate` INTEGER NOT NULL, `isDiscussionEnabled` INTEGER NOT NULL, `orderIndex` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `publication` (`id` TEXT NOT NULL, `hubId` TEXT NOT NULL, `userId` TEXT NOT NULL, `text` TEXT, `mediaUrls` TEXT NOT NULL, `previewUrls` TEXT NOT NULL, `isLiked` INTEGER NOT NULL, `likesCount` INTEGER NOT NULL, `commentsCount` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `viewType` TEXT NOT NULL, `link` TEXT, `attachedFileUrl` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `comment` (`id` TEXT NOT NULL, `publicationId` TEXT NOT NULL, `user` TEXT NOT NULL, `text` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `repliesCount` INTEGER NOT NULL, `parentCommentId` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  HubDao get hubDao {
    return _hubDaoInstance ??= _$HubDao(database, changeListener);
  }

  @override
  PublicationDao get publicationDao {
    return _publicationDaoInstance ??=
        _$PublicationDao(database, changeListener);
  }

  @override
  CommentDao get commentDao {
    return _commentDaoInstance ??= _$CommentDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userItemDataInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (UserItemData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.username,
                  'description': item.description,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'photoURL': item.photoURL,
                  'followingsCount': item.followingsCount,
                  'age': item.age
                },
            changeListener),
        _userItemDataDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (UserItemData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'username': item.username,
                  'description': item.description,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'photoURL': item.photoURL,
                  'followingsCount': item.followingsCount,
                  'age': item.age
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserItemData> _userItemDataInsertionAdapter;

  final DeletionAdapter<UserItemData> _userItemDataDeletionAdapter;

  @override
  Stream<UserItemData?> getUserStream(String userId) {
    return _queryAdapter.queryStream('SELECT * FROM user WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserItemData(
            id: row['id'] as String,
            name: row['name'] as String?,
            username: row['username'] as String?,
            description: row['description'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?,
            followingsCount: row['followingsCount'] as int?,
            age: row['age'] as int?),
        arguments: [userId],
        queryableName: 'user',
        isView: false);
  }

  @override
  Stream<List<UserItemData>> getUsersStream(List<String> userIds) {
    const offset = 1;
    final _sqliteVariablesForUserIds =
        Iterable<String>.generate(userIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'SELECT * FROM user WHERE id IN (' + _sqliteVariablesForUserIds + ')',
        mapper: (Map<String, Object?> row) => UserItemData(
            id: row['id'] as String,
            name: row['name'] as String?,
            username: row['username'] as String?,
            description: row['description'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?,
            followingsCount: row['followingsCount'] as int?,
            age: row['age'] as int?),
        arguments: [...userIds],
        queryableName: 'user',
        isView: false);
  }

  @override
  Future<UserItemData?> getUser(String userId) async {
    return _queryAdapter.query('SELECT * FROM user WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserItemData(
            id: row['id'] as String,
            name: row['name'] as String?,
            username: row['username'] as String?,
            description: row['description'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?,
            followingsCount: row['followingsCount'] as int?,
            age: row['age'] as int?),
        arguments: [userId]);
  }

  @override
  Future<void> insertUser(UserItemData user) async {
    await _userItemDataInsertionAdapter.insert(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertUsers(List<UserItemData> users) async {
    await _userItemDataInsertionAdapter.insertList(
        users, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUser(UserItemData user) async {
    await _userItemDataDeletionAdapter.delete(user);
  }

  @override
  Future<void> updateUser(UserItemData user) async {
    if (database is sqflite.Transaction) {
      await super.updateUser(user);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.userDao.updateUser(user);
      });
    }
  }
}

class _$HubDao extends HubDao {
  _$HubDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _hubItemDataInsertionAdapter = InsertionAdapter(
            database,
            'hub',
            (HubItemData item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'name': item.name,
                  'description': item.description,
                  'pictureUrl': item.pictureUrl,
                  'createdAt': item.createdAt,
                  'followersCount': item.followersCount,
                  'isFollow': item.isFollow ? 1 : 0,
                  'isPrivate': item.isPrivate ? 1 : 0,
                  'isDiscussionEnabled': item.isDiscussionEnabled ? 1 : 0,
                  'orderIndex': item.orderIndex
                },
            changeListener),
        _hubItemDataDeletionAdapter = DeletionAdapter(
            database,
            'hub',
            ['id'],
            (HubItemData item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'name': item.name,
                  'description': item.description,
                  'pictureUrl': item.pictureUrl,
                  'createdAt': item.createdAt,
                  'followersCount': item.followersCount,
                  'isFollow': item.isFollow ? 1 : 0,
                  'isPrivate': item.isPrivate ? 1 : 0,
                  'isDiscussionEnabled': item.isDiscussionEnabled ? 1 : 0,
                  'orderIndex': item.orderIndex
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HubItemData> _hubItemDataInsertionAdapter;

  final DeletionAdapter<HubItemData> _hubItemDataDeletionAdapter;

  @override
  Stream<List<HubItemData>> getHubs(String userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM hub WHERE userId = ?1 ORDER BY orderIndex ASC',
        mapper: (Map<String, Object?> row) => HubItemData(
            id: row['id'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            pictureUrl: row['pictureUrl'] as String?,
            createdAt: row['createdAt'] as int,
            followersCount: row['followersCount'] as int,
            isFollow: (row['isFollow'] as int) != 0,
            isPrivate: (row['isPrivate'] as int) != 0,
            isDiscussionEnabled: (row['isDiscussionEnabled'] as int) != 0,
            orderIndex: row['orderIndex'] as int),
        arguments: [userId],
        queryableName: 'hub',
        isView: false);
  }

  @override
  Stream<HubItemData?> getHub(String id) {
    return _queryAdapter.queryStream('SELECT * FROM hub WHERE id = ?1',
        mapper: (Map<String, Object?> row) => HubItemData(
            id: row['id'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            pictureUrl: row['pictureUrl'] as String?,
            createdAt: row['createdAt'] as int,
            followersCount: row['followersCount'] as int,
            isFollow: (row['isFollow'] as int) != 0,
            isPrivate: (row['isPrivate'] as int) != 0,
            isDiscussionEnabled: (row['isDiscussionEnabled'] as int) != 0,
            orderIndex: row['orderIndex'] as int),
        arguments: [id],
        queryableName: 'hub',
        isView: false);
  }

  @override
  Future<HubItemData?> getHubById(String id) async {
    return _queryAdapter.query('SELECT * FROM hub WHERE id = ?1',
        mapper: (Map<String, Object?> row) => HubItemData(
            id: row['id'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            pictureUrl: row['pictureUrl'] as String?,
            createdAt: row['createdAt'] as int,
            followersCount: row['followersCount'] as int,
            isFollow: (row['isFollow'] as int) != 0,
            isPrivate: (row['isPrivate'] as int) != 0,
            isDiscussionEnabled: (row['isDiscussionEnabled'] as int) != 0,
            orderIndex: row['orderIndex'] as int),
        arguments: [id]);
  }

  @override
  Stream<List<HubItemData>> getHubsByIds(List<String> hubIds) {
    const offset = 1;
    final _sqliteVariablesForHubIds =
        Iterable<String>.generate(hubIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'SELECT * FROM hub WHERE id IN (' +
            _sqliteVariablesForHubIds +
            ') ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => HubItemData(
            id: row['id'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            pictureUrl: row['pictureUrl'] as String?,
            createdAt: row['createdAt'] as int,
            followersCount: row['followersCount'] as int,
            isFollow: (row['isFollow'] as int) != 0,
            isPrivate: (row['isPrivate'] as int) != 0,
            isDiscussionEnabled: (row['isDiscussionEnabled'] as int) != 0,
            orderIndex: row['orderIndex'] as int),
        arguments: [...hubIds],
        queryableName: 'hub',
        isView: false);
  }

  @override
  Future<void> deleteHubById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM hub WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteHubsById(String userId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM hub WHERE userId = ?1',
        arguments: [userId]);
  }

  @override
  Future<void> insertHub(HubItemData hub) async {
    await _hubItemDataInsertionAdapter.insert(hub, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHubs(List<HubItemData> hubs) async {
    await _hubItemDataInsertionAdapter.insertList(
        hubs, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteHub(HubItemData hub) async {
    await _hubItemDataDeletionAdapter.delete(hub);
  }

  @override
  Future<void> updateHub(HubItemData hub) async {
    if (database is sqflite.Transaction) {
      await super.updateHub(hub);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.hubDao.updateHub(hub);
      });
    }
  }

  @override
  Future<void> updateHubs(List<HubItemData> hubs, String userId) async {
    if (database is sqflite.Transaction) {
      await super.updateHubs(hubs, userId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.hubDao.updateHubs(hubs, userId);
      });
    }
  }

  @override
  Future<void> updateFollowStatus(String hubId, bool follow) async {
    if (database is sqflite.Transaction) {
      await super.updateFollowStatus(hubId, follow);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.hubDao.updateFollowStatus(hubId, follow);
      });
    }
  }
}

class _$PublicationDao extends PublicationDao {
  _$PublicationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _publicationItemDataInsertionAdapter = InsertionAdapter(
            database,
            'publication',
            (PublicationItemData item) => <String, Object?>{
                  'id': item.id,
                  'hubId': item.hubId,
                  'userId': item.userId,
                  'text': item.text,
                  'mediaUrls': item.mediaUrls,
                  'previewUrls': item.previewUrls,
                  'isLiked': item.isLiked ? 1 : 0,
                  'likesCount': item.likesCount,
                  'commentsCount': item.commentsCount,
                  'createdAt': item.createdAt,
                  'viewType': item.viewType,
                  'link': item.link,
                  'attachedFileUrl': item.attachedFileUrl
                },
            changeListener),
        _publicationItemDataDeletionAdapter = DeletionAdapter(
            database,
            'publication',
            ['id'],
            (PublicationItemData item) => <String, Object?>{
                  'id': item.id,
                  'hubId': item.hubId,
                  'userId': item.userId,
                  'text': item.text,
                  'mediaUrls': item.mediaUrls,
                  'previewUrls': item.previewUrls,
                  'isLiked': item.isLiked ? 1 : 0,
                  'likesCount': item.likesCount,
                  'commentsCount': item.commentsCount,
                  'createdAt': item.createdAt,
                  'viewType': item.viewType,
                  'link': item.link,
                  'attachedFileUrl': item.attachedFileUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PublicationItemData>
      _publicationItemDataInsertionAdapter;

  final DeletionAdapter<PublicationItemData>
      _publicationItemDataDeletionAdapter;

  @override
  Stream<List<PublicationItemData>> getPublications(String hubId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM publication WHERE hubId = ?1 ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => PublicationItemData(
            id: row['id'] as String,
            hubId: row['hubId'] as String,
            userId: row['userId'] as String,
            text: row['text'] as String?,
            mediaUrls: row['mediaUrls'] as String,
            previewUrls: row['previewUrls'] as String,
            isLiked: (row['isLiked'] as int) != 0,
            likesCount: row['likesCount'] as int,
            commentsCount: row['commentsCount'] as int,
            createdAt: row['createdAt'] as int,
            viewType: row['viewType'] as String,
            link: row['link'] as String?,
            attachedFileUrl: row['attachedFileUrl'] as String?),
        arguments: [hubId],
        queryableName: 'publication',
        isView: false);
  }

  @override
  Stream<List<PublicationItemData>> getFeedPublications(List<String> hubIds) {
    const offset = 1;
    final _sqliteVariablesForHubIds =
        Iterable<String>.generate(hubIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'SELECT * FROM publication WHERE hubId IN (' +
            _sqliteVariablesForHubIds +
            ') ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => PublicationItemData(
            id: row['id'] as String,
            hubId: row['hubId'] as String,
            userId: row['userId'] as String,
            text: row['text'] as String?,
            mediaUrls: row['mediaUrls'] as String,
            previewUrls: row['previewUrls'] as String,
            isLiked: (row['isLiked'] as int) != 0,
            likesCount: row['likesCount'] as int,
            commentsCount: row['commentsCount'] as int,
            createdAt: row['createdAt'] as int,
            viewType: row['viewType'] as String,
            link: row['link'] as String?,
            attachedFileUrl: row['attachedFileUrl'] as String?),
        arguments: [...hubIds],
        queryableName: 'publication',
        isView: false);
  }

  @override
  Stream<PublicationItemData?> getPublication(String publicationId) {
    return _queryAdapter.queryStream('SELECT * FROM publication WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PublicationItemData(
            id: row['id'] as String,
            hubId: row['hubId'] as String,
            userId: row['userId'] as String,
            text: row['text'] as String?,
            mediaUrls: row['mediaUrls'] as String,
            previewUrls: row['previewUrls'] as String,
            isLiked: (row['isLiked'] as int) != 0,
            likesCount: row['likesCount'] as int,
            commentsCount: row['commentsCount'] as int,
            createdAt: row['createdAt'] as int,
            viewType: row['viewType'] as String,
            link: row['link'] as String?,
            attachedFileUrl: row['attachedFileUrl'] as String?),
        arguments: [publicationId],
        queryableName: 'publication',
        isView: false);
  }

  @override
  Future<void> deletePublications(String hubId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM publication WHERE hubId = ?1',
        arguments: [hubId]);
  }

  @override
  Future<void> deletePublicationById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM publication WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertPublication(PublicationItemData publication) async {
    await _publicationItemDataInsertionAdapter.insert(
        publication, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPublications(
      List<PublicationItemData> publications) async {
    await _publicationItemDataInsertionAdapter.insertList(
        publications, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePublication(PublicationItemData publication) async {
    await _publicationItemDataDeletionAdapter.delete(publication);
  }

  @override
  Future<void> updatePublication(PublicationItemData publication) async {
    if (database is sqflite.Transaction) {
      await super.updatePublication(publication);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.publicationDao.updatePublication(publication);
      });
    }
  }

  @override
  Future<void> updatePublications(
      List<PublicationItemData> publications, String hubId) async {
    if (database is sqflite.Transaction) {
      await super.updatePublications(publications, hubId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.publicationDao
            .updatePublications(publications, hubId);
      });
    }
  }
}

class _$CommentDao extends CommentDao {
  _$CommentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _commentItemDataInsertionAdapter = InsertionAdapter(
            database,
            'comment',
            (CommentItemData item) => <String, Object?>{
                  'id': item.id,
                  'publicationId': item.publicationId,
                  'user': item.user,
                  'text': item.text,
                  'createdAt': item.createdAt,
                  'repliesCount': item.repliesCount,
                  'parentCommentId': item.parentCommentId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CommentItemData> _commentItemDataInsertionAdapter;

  @override
  Stream<List<CommentItemData>> getComments(String publicationId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM comment WHERE publicationId = ?1 AND parentCommentId IS NULL ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => CommentItemData(
            id: row['id'] as String,
            user: row['user'] as String,
            publicationId: row['publicationId'] as String,
            text: row['text'] as String,
            createdAt: row['createdAt'] as int,
            repliesCount: row['repliesCount'] as int,
            parentCommentId: row['parentCommentId'] as String?),
        arguments: [publicationId],
        queryableName: 'comment',
        isView: false);
  }

  @override
  Stream<List<CommentItemData>> getCommentReplies(String parentCommentId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM comment WHERE parentCommentId = ?1 ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => CommentItemData(
            id: row['id'] as String,
            user: row['user'] as String,
            publicationId: row['publicationId'] as String,
            text: row['text'] as String,
            createdAt: row['createdAt'] as int,
            repliesCount: row['repliesCount'] as int,
            parentCommentId: row['parentCommentId'] as String?),
        arguments: [parentCommentId],
        queryableName: 'comment',
        isView: false);
  }

  @override
  Future<void> deleteComments(String publicationId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM comment WHERE publicationId = ?1',
        arguments: [publicationId]);
  }

  @override
  Future<void> deleteCommentReplies(String parentCommentId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM comment WHERE parentCommentId = ?1',
        arguments: [parentCommentId]);
  }

  @override
  Future<void> insertComment(CommentItemData comment) async {
    await _commentItemDataInsertionAdapter.insert(
        comment, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertComments(List<CommentItemData> comments) async {
    await _commentItemDataInsertionAdapter.insertList(
        comments, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateComments(
      List<CommentItemData> comments, String publicationId) async {
    if (database is sqflite.Transaction) {
      await super.updateComments(comments, publicationId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.commentDao
            .updateComments(comments, publicationId);
      });
    }
  }

  @override
  Future<void> updateCommentReplies(
      List<CommentItemData> comments, String parentCommentId) async {
    if (database is sqflite.Transaction) {
      await super.updateCommentReplies(comments, parentCommentId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$DairoDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.commentDao
            .updateCommentReplies(comments, parentCommentId);
      });
    }
  }
}

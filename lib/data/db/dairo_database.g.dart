// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dairo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT NOT NULL, `displayName` TEXT, `email` TEXT, `phoneNumber` TEXT, `photoURL` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hub` (`id` TEXT NOT NULL, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `pictureUrl` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `publication` (`id` TEXT NOT NULL, `hubId` TEXT NOT NULL, `text` TEXT, `mediaUrls` TEXT NOT NULL, `isLiked` INTEGER NOT NULL, `likesCount` INTEGER NOT NULL, `commentsCount` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `comment` (`id` TEXT NOT NULL, `publicationId` TEXT NOT NULL, `user` TEXT NOT NULL, `text` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `commentReplyId` TEXT, PRIMARY KEY (`id`))');

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
                  'displayName': item.displayName,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'photoURL': item.photoURL
                },
            changeListener),
        _userItemDataDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (UserItemData item) => <String, Object?>{
                  'id': item.id,
                  'displayName': item.displayName,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'photoURL': item.photoURL
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
            displayName: row['displayName'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?),
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
            displayName: row['displayName'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?),
        arguments: [...userIds],
        queryableName: 'user',
        isView: false);
  }

  @override
  Future<UserItemData?> getUser(String userId) async {
    return _queryAdapter.query('SELECT * FROM user WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserItemData(
            id: row['id'] as String,
            displayName: row['displayName'] as String?,
            email: row['email'] as String?,
            phoneNumber: row['phoneNumber'] as String?,
            photoURL: row['photoURL'] as String?),
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
                  'createdAt': item.createdAt
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
                  'createdAt': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HubItemData> _hubItemDataInsertionAdapter;

  final DeletionAdapter<HubItemData> _hubItemDataDeletionAdapter;

  @override
  Stream<List<HubItemData>> getUserHubsStream(String userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM hub WHERE userId = ?1 ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => HubItemData(
            id: row['id'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            pictureUrl: row['pictureUrl'] as String,
            createdAt: row['createdAt'] as int),
        arguments: [userId],
        queryableName: 'hub',
        isView: false);
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
                  'text': item.text,
                  'mediaUrls': item.mediaUrls,
                  'isLiked': item.isLiked ? 1 : 0,
                  'likesCount': item.likesCount,
                  'commentsCount': item.commentsCount,
                  'createdAt': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PublicationItemData>
      _publicationItemDataInsertionAdapter;

  @override
  Stream<List<PublicationItemData>> getPublications(String hubId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM publication WHERE hubId = ?1 ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => PublicationItemData(
            id: row['id'] as String,
            hubId: row['hubId'] as String,
            text: row['text'] as String?,
            mediaUrls: row['mediaUrls'] as String,
            isLiked: (row['isLiked'] as int) != 0,
            likesCount: row['likesCount'] as int,
            commentsCount: row['commentsCount'] as int,
            createdAt: row['createdAt'] as int),
        arguments: [hubId],
        queryableName: 'publication',
        isView: false);
  }

  @override
  Stream<PublicationItemData?> getPublication(String publicationId) {
    return _queryAdapter.queryStream('SELECT * FROM publication WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PublicationItemData(
            id: row['id'] as String,
            hubId: row['hubId'] as String,
            text: row['text'] as String?,
            mediaUrls: row['mediaUrls'] as String,
            isLiked: (row['isLiked'] as int) != 0,
            likesCount: row['likesCount'] as int,
            commentsCount: row['commentsCount'] as int,
            createdAt: row['createdAt'] as int),
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
  Future<void> deletePublication(String id) async {
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
                  'commentReplyId': item.commentReplyId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CommentItemData> _commentItemDataInsertionAdapter;

  @override
  Stream<List<CommentItemData>> getComments(String publicationId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM comment WHERE publicationId = ?1 AND commentReplyId IS NULL ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => CommentItemData(
            id: row['id'] as String,
            user: row['user'] as String,
            publicationId: row['publicationId'] as String,
            text: row['text'] as String,
            createdAt: row['createdAt'] as int,
            commentReplyId: row['commentReplyId'] as String?),
        arguments: [publicationId],
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
}

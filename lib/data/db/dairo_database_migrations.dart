import 'package:floor/floor.dart';

final migrations = [
  Migration(1, 2, (database) async {
    await database.execute('DROP TABLE IF EXISTS `user`');
    await database.execute('DROP TABLE IF EXISTS `hub`');
    await database.execute('DROP TABLE IF EXISTS `publication`');
    await database.execute('DROP TABLE IF EXISTS `comment`');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT NOT NULL, `name` TEXT, `username` TEXT, `description` TEXT, `email` TEXT, `phoneNumber` TEXT, `photoURL` TEXT, `followingsCount` INTEGER, `age` INTEGER, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `hub` (`id` TEXT NOT NULL, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT, `pictureUrl` TEXT, `createdAt` INTEGER NOT NULL, `followersCount` INTEGER NOT NULL, `isFollow` INTEGER NOT NULL, `isPrivate` INTEGER NOT NULL, `isDiscussionEnabled` INTEGER NOT NULL, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `publication` (`id` TEXT NOT NULL, `hubId` TEXT NOT NULL, `userId` TEXT NOT NULL, `text` TEXT, `mediaUrls` TEXT NOT NULL, `previewUrls` TEXT NOT NULL, `isLiked` INTEGER NOT NULL, `likesCount` INTEGER NOT NULL, `commentsCount` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `viewType` TEXT NOT NULL, `link` TEXT, `attachedFileUrl` TEXT, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `comment` (`id` TEXT NOT NULL, `publicationId` TEXT NOT NULL, `user` TEXT NOT NULL, `text` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `repliesCount` INTEGER NOT NULL, `parentCommentId` TEXT, PRIMARY KEY (`id`))');
  }),
  Migration(2, 3, (database) async {
    await database.execute('DROP TABLE IF EXISTS `user`');
    await database.execute('DROP TABLE IF EXISTS `hub`');
    await database.execute('DROP TABLE IF EXISTS `publication`');
    await database.execute('DROP TABLE IF EXISTS `comment`');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT NOT NULL, `name` TEXT, `username` TEXT, `description` TEXT, `email` TEXT, `phoneNumber` TEXT, `photoURL` TEXT, `followingsCount` INTEGER, `age` INTEGER, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `hub` (`id` TEXT NOT NULL, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT, `pictureUrl` TEXT, `createdAt` INTEGER NOT NULL, `followersCount` INTEGER NOT NULL, `isFollow` INTEGER NOT NULL, `isPrivate` INTEGER NOT NULL, `isDiscussionEnabled` INTEGER NOT NULL, `orderIndex` INTEGER NOT NULL, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `publication` (`id` TEXT NOT NULL, `hubId` TEXT NOT NULL, `userId` TEXT NOT NULL, `text` TEXT, `mediaUrls` TEXT NOT NULL, `previewUrls` TEXT NOT NULL, `isLiked` INTEGER NOT NULL, `likesCount` INTEGER NOT NULL, `commentsCount` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `viewType` TEXT NOT NULL, `link` TEXT, `attachedFileUrl` TEXT, PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `comment` (`id` TEXT NOT NULL, `publicationId` TEXT NOT NULL, `user` TEXT NOT NULL, `text` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `repliesCount` INTEGER NOT NULL, `parentCommentId` TEXT, PRIMARY KEY (`id`))');
  }),
];

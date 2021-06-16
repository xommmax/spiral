import 'dart:async';

import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';

import 'package:sqflite/sqflite.dart' as sqflite;


import 'dao/user_dao.dart';
import 'entity/user_item_data.dart';

part 'dairo_database.g.dart';

@Database(version: 1, entities: [
  UserItemData,
])
abstract class DairoDatabase extends FloorDatabase {
  @preResolve
  UserDao get userDao;
}

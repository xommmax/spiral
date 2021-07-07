import 'dart:async';

import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/hub_dao.dart';
import 'dao/user_dao.dart';
import 'entity/user_item_data.dart';

part 'dairo_database.g.dart';

@Database(version: 1, entities: [
  UserItemData,
  HubItemData,
])
abstract class DairoDatabase extends FloorDatabase {
  @preResolve
  UserDao get userDao;
  @preResolve
  HubDao get hubDao;
}

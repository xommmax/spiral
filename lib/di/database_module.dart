
import 'package:dairo/data/db/dairo_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @preResolve
  Future<DairoDatabase> get database => $FloorDairoDatabase
          .databaseBuilder('dairo_database.db')
      .build();
}

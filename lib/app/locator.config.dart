// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i9;

import '../data/api/repository/firebase_storage_repository.dart' as _i4;
import '../data/api/repository/publication_remote_repository.dart' as _i6;
import '../data/api/repository/user_remote_repository.dart' as _i10;
import '../data/db/dairo_database.dart' as _i3;
import '../data/db/repository/user_local_repository.dart' as _i9;
import '../di/database_module.dart' as _i13;
import '../di/navigation_module.dart' as _i14;
import '../domain/repository/publication/impl/publication_repository_impl.dart'
    as _i12;
import '../domain/repository/publication/publication_repository.dart' as _i11;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i16;
import '../domain/repository/user/user_repository.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final navigationModule = _$NavigationModule();

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i6;

import '../data/api/repository/user_remote_repository.dart' as _i8;
import '../data/db/dairo_database.dart' as _i3;
import '../data/db/repository/user_local_repository.dart' as _i7;
import '../di/database_module.dart' as _i11;
import '../di/firebase_module.dart' as _i12;
import '../di/navigation_module.dart' as _i13;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i10;
import '../domain/repository/user/user_repository.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final firebaseModule = _$FirebaseModule();
  final navigationModule = _$NavigationModule();
  await gh.factoryAsync<_i3.DairoDatabase>(() => databaseModule.database,
      preResolve: true);
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseModule.auth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i6.NavigationService>(
      () => navigationModule.navigationService);
  gh.lazySingleton<_i7.UserLocalRepository>(() => _i7.UserLocalRepository());
  gh.lazySingleton<_i8.UserRemoteRepository>(() => _i8.UserRemoteRepository());
  gh.lazySingleton<_i9.UserRepository>(() => _i10.UserRepositoryImpl());
  return get;
}

class _$DatabaseModule extends _i11.DatabaseModule {}

class _$FirebaseModule extends _i12.FirebaseModule {}

class _$NavigationModule extends _i13.NavigationModule {
  @override
  _i6.NavigationService get navigationService => _i6.NavigationService();
}

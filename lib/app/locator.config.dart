// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i13;

import '../data/api/helper.dart' as _i3;
import '../data/api/repository/explore_remote_repository.dart' as _i5;
import '../data/api/repository/firebase_storage_repository.dart' as _i8;
import '../data/api/repository/hub_remote_repository.dart' as _i10;
import '../data/api/repository/publication_remote_repository.dart' as _i15;
import '../data/api/repository/user_remote_repository.dart' as _i19;
import '../data/db/dairo_database.dart' as _i4;
import '../data/db/repository/hub_local_repository.dart' as _i9;
import '../data/db/repository/publication_local_repository.dart' as _i14;
import '../data/db/repository/user_local_repository.dart' as _i18;
import '../di/database_module.dart' as _i22;
import '../di/navigation_module.dart' as _i23;
import '../domain/repository/explore/explore_repository.dart' as _i6;
import '../domain/repository/explore/impl/explore_repository_impl.dart' as _i7;
import '../domain/repository/hub/hub_repository.dart' as _i11;
import '../domain/repository/hub/impl/hub_repository_impl.dart' as _i12;
import '../domain/repository/publication/impl/publication_repository_impl.dart'
    as _i17;
import '../domain/repository/publication/publication_repository.dart' as _i16;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i21;
import '../domain/repository/user/user_repository.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final navigationModule = _$NavigationModule();
  gh.lazySingleton<_i3.ApiHelper>(() => _i3.ApiHelper());
  await gh.factoryAsync<_i4.DairoDatabase>(() => databaseModule.database,
      preResolve: true);
  gh.lazySingleton<_i5.ExploreRemoteRepository>(
      () => _i5.ExploreRemoteRepository());
  gh.lazySingleton<_i6.ExploreRepository>(() => _i7.ExploreRepositoryImpl());
  gh.lazySingleton<_i8.FirebaseStorageRepository>(
      () => _i8.FirebaseStorageRepository());
  gh.lazySingleton<_i9.HubLocalRepository>(() => _i9.HubLocalRepository());
  gh.lazySingleton<_i10.HubRemoteRepository>(() => _i10.HubRemoteRepository());
  gh.lazySingleton<_i11.HubRepository>(() => _i12.HubRepositoryImpl());
  gh.lazySingleton<_i13.NavigationService>(
      () => navigationModule.navigationService);
  gh.lazySingleton<_i14.PublicationLocalRepository>(
      () => _i14.PublicationLocalRepository());
  gh.lazySingleton<_i15.PublicationRemoteRepository>(
      () => _i15.PublicationRemoteRepository());
  gh.lazySingleton<_i16.PublicationRepository>(
      () => _i17.PublicationRepositoryImpl());
  gh.lazySingleton<_i18.UserLocalRepository>(() => _i18.UserLocalRepository());
  gh.lazySingleton<_i19.UserRemoteRepository>(
      () => _i19.UserRemoteRepository());
  gh.lazySingleton<_i20.UserRepository>(() => _i21.UserRepositoryImpl());
  return get;
}

class _$DatabaseModule extends _i22.DatabaseModule {}

class _$NavigationModule extends _i23.NavigationModule {
  @override
  _i13.NavigationService get navigationService => _i13.NavigationService();
}

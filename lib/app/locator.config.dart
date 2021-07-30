// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i11;

import '../data/api/dairo_api.dart' as _i4;
import '../data/api/helper.dart' as _i3;
import '../data/api/repository/firebase_storage_repository.dart' as _i6;
import '../data/api/repository/hub_remote_repository.dart' as _i8;
import '../data/api/repository/publication_remote_repository.dart' as _i13;
import '../data/api/repository/user_remote_repository.dart' as _i17;
import '../data/db/dairo_database.dart' as _i5;
import '../data/db/repository/hub_local_repository.dart' as _i7;
import '../data/db/repository/publication_local_repository.dart' as _i12;
import '../data/db/repository/user_local_repository.dart' as _i16;
import '../di/api_module.dart' as _i20;
import '../di/database_module.dart' as _i21;
import '../di/navigation_module.dart' as _i22;
import '../domain/repository/hub/hub_repository.dart' as _i9;
import '../domain/repository/hub/impl/hub_repository_impl.dart' as _i10;
import '../domain/repository/publication/impl/publication_repository_impl.dart'
    as _i15;
import '../domain/repository/publication/publication_repository.dart' as _i14;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i19;
import '../domain/repository/user/user_repository.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  final databaseModule = _$DatabaseModule();
  final navigationModule = _$NavigationModule();
  gh.lazySingleton<_i3.ApiHelper>(() => _i3.ApiHelper());
  gh.lazySingleton<_i4.DairoApi>(() => apiModule.dairoApi);
  await gh.factoryAsync<_i5.DairoDatabase>(() => databaseModule.database,
      preResolve: true);
  gh.lazySingleton<_i6.FirebaseStorageRepository>(
      () => _i6.FirebaseStorageRepository());
  gh.lazySingleton<_i7.HubLocalRepository>(() => _i7.HubLocalRepository());
  gh.lazySingleton<_i8.HubRemoteRepository>(() => _i8.HubRemoteRepository());
  gh.lazySingleton<_i9.HubRepository>(() => _i10.HubRepositoryImpl());
  gh.lazySingleton<_i11.NavigationService>(
      () => navigationModule.navigationService);
  gh.lazySingleton<_i12.PublicationLocalRepository>(
      () => _i12.PublicationLocalRepository());
  gh.lazySingleton<_i13.PublicationRemoteRepository>(
      () => _i13.PublicationRemoteRepository());
  gh.lazySingleton<_i14.PublicationRepository>(
      () => _i15.PublicationRepositoryImpl());
  gh.lazySingleton<_i16.UserLocalRepository>(() => _i16.UserLocalRepository());
  gh.lazySingleton<_i17.UserRemoteRepository>(
      () => _i17.UserRemoteRepository());
  gh.lazySingleton<_i18.UserRepository>(() => _i19.UserRepositoryImpl());
  return get;
}

class _$ApiModule extends _i20.ApiModule {}

class _$DatabaseModule extends _i21.DatabaseModule {}

class _$NavigationModule extends _i22.NavigationModule {
  @override
  _i11.NavigationService get navigationService => _i11.NavigationService();
}

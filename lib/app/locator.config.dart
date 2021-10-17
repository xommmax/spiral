// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i16;

import '../data/api/helper.dart' as _i5;
import '../data/api/repository/explore_remote_repository.dart' as _i8;
import '../data/api/repository/firebase_storage_repository.dart' as _i11;
import '../data/api/repository/hub_remote_repository.dart' as _i13;
import '../data/api/repository/publication_remote_repository.dart' as _i18;
import '../data/api/repository/support_remote_repository.dart' as _i21;
import '../data/api/repository/user_remote_repository.dart' as _i25;
import '../data/db/dairo_database.dart' as _i7;
import '../data/db/repository/hub_local_repository.dart' as _i12;
import '../data/db/repository/publication_local_repository.dart' as _i17;
import '../data/db/repository/user_local_repository.dart' as _i24;
import '../di/database_module.dart' as _i28;
import '../di/navigation_module.dart' as _i29;
import '../domain/repository/analytics/analytics_repository.dart' as _i3;
import '../domain/repository/analytics/impl/analytics_repository_impl.dart'
    as _i4;
import '../domain/repository/explore/explore_repository.dart' as _i9;
import '../domain/repository/explore/impl/explore_repository_impl.dart' as _i10;
import '../domain/repository/hub/hub_repository.dart' as _i14;
import '../domain/repository/hub/impl/hub_repository_impl.dart' as _i15;
import '../domain/repository/publication/impl/publication_repository_impl.dart'
    as _i20;
import '../domain/repository/publication/publication_repository.dart' as _i19;
import '../domain/repository/support/impl/support_repository_impl.dart' as _i23;
import '../domain/repository/support/support_repository.dart' as _i22;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i27;
import '../domain/repository/user/user_repository.dart' as _i26;
import '../presentation/view/auth/details/auth_details_viewmodel.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final navigationModule = _$NavigationModule();
  gh.lazySingleton<_i3.AnalyticsRepository>(
      () => _i4.AnalyticsRepositoryImpl());
  gh.lazySingleton<_i5.ApiHelper>(() => _i5.ApiHelper());
  gh.lazySingleton<_i6.AuthDetailsViewModel>(() => _i6.AuthDetailsViewModel());
  await gh.factoryAsync<_i7.DairoDatabase>(() => databaseModule.database,
      preResolve: true);
  gh.lazySingleton<_i8.ExploreRemoteRepository>(
      () => _i8.ExploreRemoteRepository());
  gh.lazySingleton<_i9.ExploreRepository>(() => _i10.ExploreRepositoryImpl());
  gh.lazySingleton<_i11.FirebaseStorageRepository>(
      () => _i11.FirebaseStorageRepository());
  gh.lazySingleton<_i12.HubLocalRepository>(() => _i12.HubLocalRepository());
  gh.lazySingleton<_i13.HubRemoteRepository>(() => _i13.HubRemoteRepository());
  gh.lazySingleton<_i14.HubRepository>(() => _i15.HubRepositoryImpl());
  gh.lazySingleton<_i16.NavigationService>(
      () => navigationModule.navigationService);
  gh.lazySingleton<_i17.PublicationLocalRepository>(
      () => _i17.PublicationLocalRepository());
  gh.lazySingleton<_i18.PublicationRemoteRepository>(
      () => _i18.PublicationRemoteRepository());
  gh.lazySingleton<_i19.PublicationRepository>(
      () => _i20.PublicationRepositoryImpl());
  gh.lazySingleton<_i21.SupportRemoteRepository>(
      () => _i21.SupportRemoteRepository());
  gh.lazySingleton<_i22.SupportRepository>(() => _i23.SupportRepositoryImpl());
  gh.lazySingleton<_i24.UserLocalRepository>(() => _i24.UserLocalRepository());
  gh.lazySingleton<_i25.UserRemoteRepository>(
      () => _i25.UserRemoteRepository());
  gh.lazySingleton<_i26.UserRepository>(() => _i27.UserRepositoryImpl());
  return get;
}

class _$DatabaseModule extends _i28.DatabaseModule {}

class _$NavigationModule extends _i29.NavigationModule {
  @override
  _i16.NavigationService get navigationService => _i16.NavigationService();
}

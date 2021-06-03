// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i3;

import '../data/api/repository/user_remote_repository.dart' as _i5;
import '../data/db/repository/user_local_repository.dart' as _i4;
import '../di/navigation_module.dart' as _i8;
import '../domain/repository/user/impl/user_repository_impl.dart' as _i7;
import '../domain/repository/user/user_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final navigationModule = _$NavigationModule();
  gh.lazySingleton<_i3.NavigationService>(
      () => navigationModule.navigationService);
  gh.lazySingleton<_i4.UserLocalRepository>(() => _i4.UserLocalRepository());
  gh.lazySingleton<_i5.UserRemoteRepository>(() => _i5.UserRemoteRepository());
  gh.lazySingleton<_i6.UserRepository>(() => _i7.UserRepositoryImpl());
  return get;
}

class _$NavigationModule extends _i8.NavigationModule {
  @override
  _i3.NavigationService get navigationService => _i3.NavigationService();
}

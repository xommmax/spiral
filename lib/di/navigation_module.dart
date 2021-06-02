import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class NavigationModule {
  @lazySingleton
  NavigationService get navigationService;
}

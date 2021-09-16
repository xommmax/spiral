import 'package:dairo/domain/model/user/sign_up_method.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AnalyticsRepository)
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver? _observer;

  void _initObserver() {
    _observer = FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  FirebaseAnalyticsObserver getObserver() {
    if (_observer == null) {
      _initObserver();
    }
    return _observer!;
  }

  @override
  Future<void> logAppOpen() => _analytics.logAppOpen();

  @override
  Future<void> logSignUp({
    required AuthMethod authMethod,
  }) =>
      _analytics.logSignUp(
        signUpMethod: authMethod.toShortString(),
      );

  @override
  Future<void> logLogin({
    required AuthMethod authMethod,
  }) =>
      _analytics.logLogin(
        loginMethod: authMethod.toShortString(),
      );

  @override
  Future<void> setUserId({
    required String userId,
  }) =>
      _analytics.setUserId(userId);

  @override
  Future<void> setCurrentScreen({
    required String screenName,
  }) =>
      _analytics.setCurrentScreen(
        screenName: screenName,
      );

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) =>
      _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
}

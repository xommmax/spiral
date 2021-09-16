import 'package:dairo/domain/model/user/sign_up_method.dart';
import 'package:firebase_analytics/observer.dart';

abstract class AnalyticsRepository {
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  });

  Future<void> logAppOpen();

  Future<void> logSignUp({
    required AuthMethod authMethod,
  });

  Future<void> logLogin({
    required AuthMethod authMethod,
  });

  Future<void> setCurrentScreen({
    required String screenName,
  });

  Future<void> setUserId({
    required String userId,
  });

  FirebaseAnalyticsObserver getObserver();
}

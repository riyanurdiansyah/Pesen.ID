import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<void> changePage(String name) async {
    await analytics.logEvent(name: name);
  }
}

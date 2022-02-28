import 'package:pesen_id/controllers/splash_c.dart';
import 'package:get/get.dart';

class SplashBind extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashC());
  }
}

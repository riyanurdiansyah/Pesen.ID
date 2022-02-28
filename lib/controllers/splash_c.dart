import 'package:pesen_id/routes/routes_name.dart';
import 'package:get/get.dart';

class SplashC extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(AppRoutesName.dashboard);
    });
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<SplashC>();
  }
}

import 'package:pesen_id/controllers/auth_c.dart';
import 'package:get/get.dart';

class AuthBind implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthC());
  }
}

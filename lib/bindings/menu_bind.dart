import 'package:pesen_id/controllers/auth_c.dart';
import 'package:pesen_id/controllers/menu_c.dart';
import 'package:get/get.dart';

class MenuBind implements Bindings {
  @override
  void dependencies() {
    Get.put(MenuC());
  }
}

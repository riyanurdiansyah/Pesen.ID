import 'package:pesen_id/controllers/dashboard_c.dart';
import 'package:get/get.dart';

class DashboardBind extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardC());
  }
}

import 'package:pesen_id/controllers/detail_c.dart';
import 'package:get/get.dart';

class DetailBind extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailC());
  }
}

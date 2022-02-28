import 'package:pesen_id/controllers/auth_c.dart';
import 'package:pesen_id/controllers/search_c.dart';
import 'package:get/get.dart';

class SearchBind implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchC());
  }
}

import 'package:tea_tasting/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

mixin HomeMixin {
  void reloadHomeData() {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().getAllRecords();
    }
  }
}

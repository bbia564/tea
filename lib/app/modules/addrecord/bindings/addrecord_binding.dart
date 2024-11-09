import 'package:get/get.dart';

import '../controllers/addrecord_controller.dart';

class AddrecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddrecordController>(
      () => AddrecordController(),
    );
  }
}

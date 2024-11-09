import 'package:get/get.dart';

import 'tea_cool_logic.dart';

class TeaCoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}

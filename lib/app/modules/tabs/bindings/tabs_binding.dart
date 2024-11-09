import 'package:tea_tasting/app/modules/category/controllers/category_controller.dart';
import 'package:tea_tasting/app/modules/home/controllers/home_controller.dart';
import 'package:tea_tasting/app/modules/mine/controllers/mine_controller.dart';
import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
  }
}

import 'package:tea_tasting/app/database/database.dart';
import 'package:tea_tasting/app/mixin/home_mixn.dart';
import 'package:tea_tasting/app/modules/tools/components.dart';
import 'package:tea_tasting/app/modules/tools/toast_tool.dart';
import 'package:get/get.dart';

class MineController extends GetxController with HomeMixin {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addCustom() {
    Get.dialog(FFFFFFPDialog(
      title: "Add catogory",
      content: "catogory name",
      type: FFFFFFDialogType.input,
      onCancle: Get.back,
      inputAction: (name) {
        Get.back();
      },
      onAction: () {},
    ));
  }

  void addAndRefresh() {}

  void cellOpressed(index) async {
    if (index == 0) {
      final cancel = FFFFFFtoastTool.ffffffshowLoading();
      await FFFFFFDatabase().clean();
      reloadHomeData();
      cancel();
      FFFFFFtoastTool.ffffffShowText("Clear Success");
    } else if (index == 2) {
      Get.dialog(FFFFFFPDialog(
          title: "Version",
          content: "1.0.0",
          buttonNum: 1,
          onAction: () {
            Get.back();
          }));
    }
  }
}

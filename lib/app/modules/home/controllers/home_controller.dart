import 'package:tea_tasting/app/data/homedata.dart';
import 'package:tea_tasting/app/database/database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final records = <RecordModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getAllRecords();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void itemClick(RecordModel item) async {
    Get.toNamed('/addrecord', arguments: {"record": item, "isEdit": false});
  }

  void getAllRecords() async {
    String time = FFFFFFDatabase().lastTime;
    final hastime = time.isNotEmpty;
    await FFFFFFDatabase().getAll().then((result) {
      if (result != null) {
        records.value = result;
      }
    });

    if (!hastime) {
      for (var i = records.value.length - 1; i > 0; i--) {
        final item = records.value[i];
        if (item.time?.isNotEmpty ?? false) {
          FFFFFFDatabase().lastTime = item.time!;
          return;
        }
      }
    }
  }
}

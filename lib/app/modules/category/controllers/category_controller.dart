import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tea_tasting/app/data/homedata.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final allteas = [].obs;

  @override
  void onInit() {
    super.onInit();
    getAlldatas();
  }

  void getAlldatas() async {
    String jsonString = await rootBundle.loadString('assets/tea.json');
    Map<String, dynamic> data = jsonDecode(jsonString);
    allteas.value = data["all"];
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addNew(String title) {
    final newRecord = RecordModel();
    newRecord.title = title;
    newRecord.comment = "";
    newRecord.image = "";
    newRecord.record = 0;

    Get.toNamed('/addrecord',
        arguments: {"record": newRecord, "isEdit": true});
  }
}

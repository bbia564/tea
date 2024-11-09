import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tea_tasting/app/data/homedata.dart';
import 'package:tea_tasting/app/database/database.dart';
import 'package:tea_tasting/app/mixin/home_mixn.dart';
import 'package:tea_tasting/app/modules/tools/img_picker_tool.dart';
import 'package:tea_tasting/app/modules/tools/toast_tool.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/componets.dart';

class AddrecordController extends GetxController with HomeMixin {
  final RecordModel record = Get.arguments["record"];
  final bool isEdit = Get.arguments["isEdit"] ?? false;
  final recordStar = 0.obs;
  final recordImage = "".obs;
  String comment = "";
  @override
  void onInit() {
    super.onInit();
    recordStar.value = record.record ?? 0;
    recordImage.value = record.image ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void choseImage(BuildContext context) async {
    if (!isEdit) {
      return;
    }

    final file = await rmPickSingleImageXFile();
    if (file == null) {
      return;
    }
    decodeImage(file);
  }

  void decodeImage(XFile file) async {
    final bytes = await file.readAsBytes();
    recordImage.value = base64Encode(bytes);
  }

  void addNew() async {
    if (comment.isEmpty) {
      FFFFFFtoastTool.ffffffShowText("Please input how about this tea");
      return;
    }

    if (recordImage.value.isEmpty) {
      FFFFFFtoastTool.ffffffShowText("Please chooise a photo");
      return;
    }

    final time = DateTime.now();
    final timeStr = "${time.year}/${time.month}/${time.day}";
    record.record = recordStar.value;
    record.image = recordImage.value;
    record.time = timeStr;
    record.comment = comment;

    await FFFFFFDatabase().insert(record);
    reloadHomeData();
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
  }
}

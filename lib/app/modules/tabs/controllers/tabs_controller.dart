import 'package:flutter/material.dart';
import 'package:tea_tasting/app/database/database.dart';
import 'package:tea_tasting/app/modules/category/views/category_view.dart';
import 'package:tea_tasting/app/modules/home/views/home_view.dart';
import 'package:tea_tasting/app/modules/mine/views/mine_view.dart';
import 'package:get/get.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  List<Widget> pageList = [
    const HomeView(),
    const CategoryView(),
    const MineView(),
  ];

  @override
  void onInit() {
    super.onInit();
    initDB();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initDB() async {
    await FFFFFFDatabase().init();
  }

  void changeCurrentPageIndex(int index) {
    currentIndex.value = index;
  }
}

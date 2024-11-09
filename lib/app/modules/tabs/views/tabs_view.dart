import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:tea_tasting/common/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  Widget _home_bottom_bar_icon(String name) {
    return Image.asset(
      name,
      height: 22.h,
      width: 22.h,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              controller.currentIndex.value = value;
            },
            children: controller.pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            fixedColor: FFFFFFColorTools.main_green, //选中颜色
            elevation: 5.0,

            onTap: (value) {
              controller.currentIndex.value = value;
              controller.pageController.jumpToPage(value);
            },

            items: [
              BottomNavigationBarItem(
                  icon: _home_bottom_bar_icon(Assets.homeNormal),
                  activeIcon: _home_bottom_bar_icon(Assets.homeSelected),
                  label: "Taste"),
              BottomNavigationBarItem(
                label: "Catogory",
                icon: _home_bottom_bar_icon(Assets.categoryNormal),
                activeIcon: _home_bottom_bar_icon(Assets.categorySelected),
              ),
              BottomNavigationBarItem(
                  icon: _home_bottom_bar_icon(Assets.mineNormal),
                  activeIcon: _home_bottom_bar_icon(Assets.mineSelected),
                  label: "About"),
            ],
          ),
        ));
  }
}

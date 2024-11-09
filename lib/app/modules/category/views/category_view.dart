import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/base/base_stack_bg_view.dart';
import 'package:tea_tasting/app/modules/base/common_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends BaseStackBgView<CategoryController> {
  const CategoryView({super.key});

  @override
  String appBarTitle() {
    return "Catogory";
  }

  @override
  Widget subViewsBuild(BuildContext context) {
    return Obx(() => ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.allteas.length,
          itemBuilder: (context, index) {
            final tea = controller.allteas[index];
            return InkWell(
              onTap: () {
                controller.addNew(tea);
              },
              child: ffffffgetContainer(
                  radius: 10.w,
                 
                  width: double.infinity,
                  padding: EdgeInsets.all(15.h),
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: ffffffcustom_cell(title: tea, fontSize: 16)),
            );
          },
        ));
  }
}

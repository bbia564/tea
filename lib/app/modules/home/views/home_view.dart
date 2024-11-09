import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/base/base_stack_bg_view.dart';
import 'package:tea_tasting/app/modules/home/views/record_cell.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseStackBgView<HomeController> {
  const HomeView({super.key});

  @override
  String appBarTitle() {
    return "Tea tasting record";
  }

  @override
  Widget subViewsBuild(BuildContext context) {
    return Obx(() {
      return controller.records.isEmpty
          ? Center(
              child: Text(
                "no data yet",
                style: TextStyle(
                    color: FFFFFFColorTools.fffffhexColor("#999999"),
                    fontSize: 12.sp),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.records.length,
              itemBuilder: (context, index) {
                final model = controller.records[index];
                return InkWell(
                  onTap: () {
                    controller.itemClick(model);
                  },
                  child: RecordCell(model: model),
                );
              },
            );
    });
  }
}

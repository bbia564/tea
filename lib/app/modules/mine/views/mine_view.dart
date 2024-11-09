import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/base/base_stack_bg_view.dart';
import 'package:tea_tasting/app/modules/base/common_view.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/mine_controller.dart';

class MineView extends BaseStackBgView<MineController> {
  const MineView({super.key});

  @override
  String appBarTitle() {
    return "About";
  }

  @override
  Widget subViewsBuild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          InkWell(
            onTap: controller.addCustom,
            child: ffffffgetContainer(
                radius: 10,
                height: 48.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ffffffcustom_cell(
                  title: "Custom category",
                )),
          ),
          10.verticalSpace,
          ffffffgetContainer(
              radius: 10,
              width: double.infinity,
              padding: EdgeInsets.all(15.h),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.cellOpressed(0);
                    },
                    child: ffffffcustom_cell(
                      title: "Clear",
                    ),
                  ),
                  9.verticalSpace,
                  Divider(
                    color: FFFFFFColorTools.fffffhexColor("#EFEFEF"),
                  ),
                  12.verticalSpace,
                  InkWell(
                      onTap: () {
                        controller.cellOpressed(2);
                      },
                      child: ffffffcustom_cell(
                        title: "About",
                      ))
                ],
              ))
        ],
      ),
    );
  }
}

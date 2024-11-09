import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/base/common_view.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:tea_tasting/common/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/addrecord_controller.dart';

class AddrecordView extends GetView<AddrecordController> {
  const AddrecordView({Key? key}) : super(key: key);
  Widget recordStarView() {
    List<Widget> list = [];
    for (var i = 0; i < 5; i++) {
      final isgreen = controller.recordStar.value >= i;
      list.add(InkWell(
        onTap: () {
          if (controller.isEdit) {
            controller.recordStar.value = i;
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Image.asset(isgreen ? Assets.starSelected : Assets.statNormal,
              height: 12.h, width: 12.h),
        ),
      ));
    }
    return Row(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = controller.record;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: FFFFFFColorTools.main_title_text_color),
        ),
        centerTitle: true,
        backgroundColor: FFFFFFColorTools.main_white_color,
      ),
      backgroundColor: FFFFFFColorTools.fffffhexColor("#F4F7F4"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ffffffgetContainer(
                radius: 10.w,
                color: FFFFFFColorTools.main_white_color,
                padding: EdgeInsets.fromLTRB(16.w, 18.w, 16.w, 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.greenIcon,
                          height: 10.w,
                          width: 10.w,
                        ),
                        6.horizontalSpace,
                        ffffffTextbold(model.title ?? "-")
                      ],
                    ),
                    16.verticalSpace,
                    Divider(
                      color: FFFFFFColorTools.fffffhexColor("#EFEFEF"),
                    ),
                    11.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ffffffTextbold("Evaluate${model.title}："),
                        5.horizontalSpace,
                        Obx(() => recordStarView())
                      ],
                    ),
                    9.verticalSpace,
                    Divider(
                      color: FFFFFFColorTools.fffffhexColor("#EFEFEF"),
                    ),
                    11.verticalSpace,
                    _inputView(),
                    10.verticalSpace,
                    Obx(() {
                      final hasImg = controller.recordImage.value.isNotEmpty;
                      return InkWell(
                        onTap: () {
                          controller.choseImage(context);
                        },
                        child: hasImg
                            ? (controller.recordImage.value != "logo" && controller.recordImage.value.contains('assets')  == false)
                                ? Image.memory(
                                    base64Decode(controller.recordImage.value),
                                    width: 93.w,
                                    height: 109.h,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    controller.recordImage.value,
                                    width: 95.w,
                                    height: 109.h,
                                    fit: BoxFit.fill,
                                  )
                            : Container(
                                width: 90.w,
                                height: 90.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: FFFFFFColorTools.fffffhexColor(
                                        "#F7F7F7"),
                                    borderRadius: BorderRadius.circular(10.w)),
                                child: Image.asset(
                                  Assets.addimgIcon,
                                  height: 21.w,
                                  width: 21.w,
                                ),
                              ),
                      );
                    })
                  ],
                )),
            20.verticalSpace,
            controller.isEdit
                ? InkWell(
                    onTap: controller.addNew,
                    child: ffffffgetContainer(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 50.h,
                        radius: 25.h,
                        color: FFFFFFColorTools.main_green,
                        alignment: Alignment.center,
                        child: ffffffTextbold("Submit",
                            textColor: FFFFFFColorTools.main_white_color)),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  //输入框Cell
  Widget _inputView() {
    return SizedBox(
      height: 100.h,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: TextFormField(
          enabled: controller.isEdit,
          initialValue: controller.record.comment ?? "",
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "How about", counterText: ""),
          maxLength: 200,
          maxLines: 12,
          onChanged: (value) {
            controller.comment = value;
          },
        ),
      ),
    );
  }
}

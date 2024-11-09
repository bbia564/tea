import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tea_tasting/app/data/homedata.dart';
import 'package:tea_tasting/app/modules/base/common_view.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:tea_tasting/common/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordCell extends StatelessWidget {
  final RecordModel model;
  const RecordCell({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noTime = model.time?.isEmpty ?? true;
    return noTime
        ? _contenView()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.recordIcon,
                    height: 20.h,
                    width: 17.w,
                  ),
                  5.horizontalSpace,
                  ffffffTextbold(model.time ?? "")
                ],
              ),
              12.verticalSpace,
              _contenView()
            ],
          );
  }

  Widget _contenView() {
    return ffffffgetContainer(
        radius: 10.w,
        // height: 135.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                child: (model.image != "logo" && model.image?.contains('assets') == false)
                    ? Image.memory(
                  base64Decode(model.image!),
                        width: 93.w,
                        height: 109.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        model.image!,
                        width: 95.w,
                        height: 109.h,
                        fit: BoxFit.fill,
                      )),
            14.horizontalSpace,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ffffffcustom_cell(title: model.title ?? "-"),
                6.verticalSpace,
                Divider(
                  color: FFFFFFColorTools.fffffhexColor("#EFEFEF"),
                ),
                6.verticalSpace,
                Text(model.comment ?? "-",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                      color: FFFFFFColorTools.fffffhexColor("#B2B2B2"),
                      fontSize: 12.sp,
                    )),
                7.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Evaluate:",
                      style: TextStyle(
                          color: FFFFFFColorTools.main_green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                    6.horizontalSpace,
                    starView(model.record ?? 0)
                  ],
                )
              ],
            ))
          ],
        ));
  }
}

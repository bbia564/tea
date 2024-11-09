import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

abstract class BaseStackBgView<T extends GetxController> extends GetView<T> {
  const BaseStackBgView({super.key});

  Widget _buildBgView() {
    return Image.asset(
      "assets/images/bg_img.png",
      width: 1.sw,
      height: 1.sh,
      fit: BoxFit.fill,
    );
  }

  String appBarTitle();
  Widget subViewsBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitle(),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: FFFFFFColorTools.main_title_text_color),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: FFFFFFColorTools.main_white_color,
        body: Stack(
          children: [
            _buildBgView(),
            Positioned(
              top:
                  kMinInteractiveDimension + MediaQuery.of(context).padding.top,
              bottom: 0,
              right: 0,
              left: 0,
              child: subViewsBuild(context),
            ),
          ],
        ));
  }
}
  /// 背景图view
  
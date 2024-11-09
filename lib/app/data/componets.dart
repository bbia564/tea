import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'permission_util.dart';


Container rmGetContainer(
    {Key? key,
    double? width,
    double? height,
    double radius = 0,
    Color color = Colors.white,
    double borderWidth = 0.0,
    Color borderColor = const Color(0x00000fff),
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    Widget? child,
    Gradient? gradient,
    List<BoxShadow>? shadow,
    ImageProvider? bgImg,
    BoxFit? fit,
    Clip? clipBehavior}) {
  return Container(
    key: key,
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
        color: color,
        gradient: gradient,
        boxShadow: shadow,
        image: bgImg != null
            ? DecorationImage(
                image: bgImg,
                fit: fit ?? BoxFit.contain,
              )
            : null),
    alignment: alignment,
    padding: padding,
    margin: margin,
    clipBehavior: clipBehavior ?? Clip.antiAlias,
    child: child,
  );
}

Future<XFile?> rmPickSingleImageXFile() async {
  bool status = false;
  if (Platform.isAndroid) {
    Permission permission = await PermissionUtil.getMediumPermission();
    status = await PermissionUtil.checkPermission([permission]);
  } else {
    status = true;
  }

  if (status) {
    final picker = ImagePicker();
    final res = await picker.pickImage(
      imageQuality: 90,
      maxWidth: 1024,
      source: ImageSource.gallery,
    );

    return res;
  }
  return null;
}

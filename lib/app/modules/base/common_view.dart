import 'package:flutter/material.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:tea_tasting/common/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container ffffffgetContainer(
    {double? width,
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

Container ffffffgetTextField(String hint, double size,
    {bool isBorder = false,
    bool isFocus = false,
    double height = 40,
    int maxLines = 1,
    String text = "",
    TextInputType type = TextInputType.text,
    TextAlign align = TextAlign.left,
    double width = double.infinity,
    bool isUnderLine = false,
    TextEditingController? controller,
    Color bgColor = Colors.transparent,
    Widget? prefixIcon,
    double prefixSize = 0,
    Color? hintColor,
    int? maxLength,
    double? radius,
    bool? enabled,
    EdgeInsetsGeometry? padding,
    ValueChanged<String>? onChanged,
    inputFormatters,
    readOnly = false,
    focusNode}) {
  return ffffffgetContainer(
      width: width,
      height: maxLines == 1 ? height : null,
      color: bgColor,
      radius: radius ?? 17.w,
      borderWidth: isBorder ? 1 : 0,
      borderColor:
          isBorder ? Colors.black.withOpacity(0.2) : Colors.transparent,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      child: TextField(
        inputFormatters: inputFormatters,
        autofocus: isFocus,
        showCursor: true,
        style: TextStyle(
          fontSize: size,
          color: Colors.black,
        ),
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller ?? TextEditingController(text: text),
        keyboardType: type,
        enabled: enabled,
        textAlign: align,
        textAlignVertical: TextAlignVertical.center,
        scrollPadding: EdgeInsets.zero,
        expands: false,
        onChanged: onChanged,
        readOnly: readOnly,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: isUnderLine
                ? UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: FFFFFFColorTools.main_light_grey))
                : InputBorder.none,
            focusedBorder: isUnderLine
                ? UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: FFFFFFColorTools.main_light_grey))
                : InputBorder.none,
            // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            hintText: hint,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixSize == 0
                ? null
                : BoxConstraints(
                    maxWidth: prefixSize,
                    maxHeight: prefixSize,
                    minWidth: prefixSize,
                    minHeight: prefixSize),
            // isCollapsed: true,
            isDense: true,
            hintStyle: TextStyle(
              fontSize: size,
              color: hintColor ?? Colors.black.withOpacity(0.4),
            ),
            counterText: ''),
      ));
}

Widget ffffffcustom_cell({required String title, double fontSize = 14}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: fontSize.sp,
            color: FFFFFFColorTools.main_content_text_color,
            fontWeight: FontWeight.w600),
      ),
      Image.asset(
        Assets.arrowRight,
        height: 16.h,
        width: 12.w,
      )
    ],
  );
}

Widget starView(int record) {
  List<Widget> list = [];
  for (var i = 0; i < 5; i++) {
    final isgreen = record >= i;
    list.add(Padding(
      padding: EdgeInsets.only(left: 2.w),
      child: Image.asset(isgreen ? Assets.starSelected : Assets.statNormal,
          height: 12.h, width: 12.h),
    ));
  }
  return Row(
    children: list,
  );
}

Widget ffffffTextbold(String text,
    {double fontSize = 16, FontWeight fontWeight = FontWeight.bold, Color? textColor}) {
  return Text(
    text,
    style: TextStyle(
        color: textColor ?? FFFFFFColorTools.main_content_text_color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight),
  );
}

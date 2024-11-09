import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:tea_tasting/app/modules/tools/toast_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'color_tools.dart';

//组件状态缓存
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper(
      {Key? key, @required this.child, this.keepAlive = true})
      : super(key: key);

  final Widget? child;
  final bool keepAlive;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }
}

enum FFFFFFDialogType { normal, custom, input }

class FFFButton extends StatelessWidget {
  final double radius;
  final String title;
  final Function() onPressed;
  const FFFButton(
      {Key? key, this.title = "确定", required this.onPressed, this.radius = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      colors: [FFFFFFColorTools.main_green, FFFFFFColorTools.main_green],
      borderRadius: BorderRadius.circular(radius),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: FFFFFFColorTools.main_white_color),
      ),
    );
  }
}

///弹框
class FFFFFFPDialog extends StatelessWidget {
  ///标题
  String? title;

  ///内容
  String? content;

  ///弹出框类型 默认还是自定义
  FFFFFFDialogType type;

  /// 1个 还是两个 button
  int buttonNum;

  ///左侧button的标题
  String leftActionTitle;

  ///右侧button的标题
  String rightActionTitle;

  ///左侧button的点击事件
  Function()? onCancle;

  ///右侧button 或只有一个button的点击事件
  Function() onAction;

  ///为输入框时的输入内容
  Function(String)? inputAction;

  ///自定义弹出内容时的视图
  List<Widget>? contentWidgets;

  ///自定义的输入框视图
  Widget? input;

  ///输入框输入的文字
  String? inputString;

  ///弹出框内容是个输入框的时候的占位文字
  String? inputPlaceHold;

  ///两个button是否样式一致（渐变button） 否则是一个outsidebutton 一个渐变背景button
  bool sameButtonStyle;

  FFFFFFPDialog(
      {Key? key,
      this.type = FFFFFFDialogType.normal,
      this.title,
      this.content,
      this.onCancle,
      required this.onAction,
      this.inputAction,
      this.buttonNum = 2,
      this.leftActionTitle = "Cancel",
      this.rightActionTitle = "Confirm",
      this.contentWidgets,
      this.inputPlaceHold,
      this.sameButtonStyle = false})
      : super(key: key);

  Widget _antionsRow() {
    if (buttonNum == 2) {
      return Row(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: 40.h,
                  child: sameButtonStyle
                      ? FFFButton(
                          radius: 20.h,
                          title: leftActionTitle,
                          onPressed: onCancle!,
                        )
                      : OutlinedButton(
                          onPressed: onCancle,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                FFFFFFColorTools.main_white_color),
                            side: WidgetStateProperty.all(
                                BorderSide(color: FFFFFFColorTools.main_green)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Text(
                            leftActionTitle,
                            style: TextStyle(
                                color: FFFFFFColorTools.main_title_text_color),
                          ),
                        ))),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 40.h,
                child: FFFButton(
                  radius: 20.h,
                  title: rightActionTitle,
                  onPressed: () {
                    if (type == FFFFFFDialogType.input) {
                      if (inputString == null || inputString!.isEmpty) {
                        FFFFFFtoastTool.ffffffShowText("Please input");
                        return;
                      }
                      inputAction!(inputString!);
                    } else {
                      onAction();
                    }
                  },
                ),
              ))
        ],
      );
    } else {
      return SizedBox(
        height: 46,
        width: 200.w,
        child: FFFButton(
          radius: 23,
          title: rightActionTitle,
          onPressed: onAction,
        ),
      );
    }
  }

  List<Widget> _normalView() {
    return [
      SizedBox(
        height: 50.h,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: FFFFFFColorTools.main_content_text_color,
                fontSize: 14.sp),
          ),
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      Text(
        content ?? "",
        maxLines: 10,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: FFFFFFColorTools.main_content_text_color,
          fontSize: 12.sp,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> _inputView() {
    return [
      SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: FFFFFFColorTools.main_content_text_color,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
      TextFormField(
          initialValue: "",
          onChanged: (v) {
            inputString = v;
          },
          style: TextStyle(color: FFFFFFColorTools.main_content_text_color),
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: FFFFFFColorTools.main_green, width: 0.5)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: FFFFFFColorTools.fffffhexColor("#D3D3D3"),
              )),
              hintText: "Please input",
              counterText: "",
              hintStyle:
                  TextStyle(color: FFFFFFColorTools.fffffhexColor("#B9B9B9"))),
          maxLength: 8,
          maxLines: 1),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> viewFromType() {
    switch (type) {
      case FFFFFFDialogType.custom:
        return contentWidgets ?? List.empty();
      case FFFFFFDialogType.input:
        return _inputView();
      case FFFFFFDialogType.normal:
        return _normalView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
          child: Container(
              width: 300.w,
              decoration: BoxDecoration(
                color: FFFFFFColorTools.main_white_color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[...viewFromType(), _antionsRow()],
                ),
              ))),
    );
  }
}

///渐变button
class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    required this.onPressed,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];
    final radius = borderRadius;
    bool disabled = onPressed == null;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: disabled ? null : LinearGradient(colors: _colors),
        color: disabled ? disabledColor ?? theme.disabledColor : null,
        borderRadius: radius,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radius,
        clipBehavior: Clip.hardEdge,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          child: InkWell(
            splashColor: splashColor ?? _colors.last,
            highlightColor: Colors.transparent,
            onHighlightChanged: onHighlightChanged,
            onTap: onPressed,
            child: Padding(
              padding: padding ?? theme.buttonTheme.padding,
              child: DefaultTextStyle(
                style: const TextStyle(fontWeight: FontWeight.w500),
                child: Center(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: DefaultTextStyle(
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: disabled
                          ? disabledTextColor ?? Colors.black38
                          : textColor ?? Colors.white,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///渐变button
class ElevatedGradientButton extends StatefulWidget {
  const ElevatedGradientButton({
    Key? key,
    this.colors,
    this.onPressed,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
    this.shadowColor,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  _ElevatedGradientButtonState createState() => _ElevatedGradientButtonState();
}

class _ElevatedGradientButtonState extends State<ElevatedGradientButton> {
  bool _tapDown = false;

  @override
  Widget build(BuildContext context) {
    bool disabled = widget.onPressed == null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: disabled
            ? null
            : [
                _tapDown
                    ? BoxShadow(
                        offset: const Offset(2, 6),
                        spreadRadius: -2,
                        blurRadius: 9,
                        color: widget.shadowColor ?? Colors.black54,
                      )
                    : BoxShadow(
                        offset: const Offset(0, 2),
                        spreadRadius: -2,
                        blurRadius: 3,
                        color: widget.shadowColor ?? Colors.black87,
                      )
              ],
      ),
      child: GradientButton(
        colors: widget.colors,
        onPressed: widget.onPressed,
        padding: widget.padding,
        borderRadius: widget.borderRadius,
        textColor: widget.textColor,
        splashColor: widget.splashColor,
        disabledColor: widget.disabledColor,
        disabledTextColor: widget.disabledTextColor,
        child: widget.child,
        onHighlightChanged: (v) {
          setState(() {
            _tapDown = v;
          });
          if (widget.onHighlightChanged != null) {
            widget.onHighlightChanged!(v);
          }
        },
      ),
    );
  }
}

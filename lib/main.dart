import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:tea_tasting/app/modules/tools/color_tools.dart';
import 'package:tea_tasting/app/modules/tools/normal_tools.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/modules/addrecord/bindings/addrecord_binding.dart';
import 'app/modules/addrecord/views/addrecord_view.dart';
import 'app/modules/category/bindings/category_binding.dart';
import 'app/modules/category/views/category_view.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/mine/bindings/mine_binding.dart';
import 'app/modules/mine/views/mine_view.dart';
import 'app/modules/tabs/bindings/tabs_binding.dart';
import 'app/modules/tabs/views/tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runZonedGuarded(
    () => init(),
    (err, stace) {
      if (kDebugMode) {
        print(FlutterErrorDetails(exception: err, stack: stace));
      }
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, line);
      },
    ),
  );
}

void init() async {
  runApp(_initApp());
}

_initConfig() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Widget initGetMaterialApp({
  Widget Function(BuildContext, Widget?)? builder,
}) {
  return GetMaterialApp(
    initialRoute: '/tabs',
    getPages: Lists,
    defaultTransition: Transition.rightToLeft,
    theme: lightThemData,
    darkTheme: darkThemData,
    useInheritedMediaQuery: true,
    themeMode: ThemeMode.light,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    fallbackLocale: const Locale("zh", "CN"),
    supportedLocales: const [
      Locale('zh', 'CN'),
      Locale('en', 'US'),
    ],
    debugShowCheckedModeBanner: false,
    builder: builder,
    navigatorObservers: [BotToastNavigatorObserver()],
  );
}

_initRootGestureDetector({
  Widget? child,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      fffff_normal_tools.keydissmiss(context);
    },
    child: child,
  );
}

Widget initScreenUtil({
  required Widget Function(BuildContext, Widget?) builder,
  bool useInheritedMediaQuery = true,
}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    useInheritedMediaQuery: useInheritedMediaQuery,
    builder: builder,
  );
}

_initApp() {
  if (!kIsWeb) {
    _initConfig();
  }

  Widget body = initGetMaterialApp(
    builder: (context, child) {
      final botToastBuilder = BotToastInit();
      return initScreenUtil(
        builder: (p0, p1) {
          Widget body = _initRootGestureDetector(
            child: child,
            context: context,
          );

          body = botToastBuilder(context, body);
          return body;
        },
      );
    },
  );
  return body;
}

final lightThemData = ThemeData(
  brightness: Brightness.light,
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.white.withOpacity(0),
  scaffoldBackgroundColor: FFFFFFColorTools.main_white_color,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0.0,
  ),
);
final darkThemData = ThemeData.dark();

List<GetPage<dynamic>> Lists = [
  GetPage(
    name: '/home',
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/tabs',
    page: () => const TabsView(),
    binding: TabsBinding(),
  ),
  GetPage(
    name: '/category',
    page: () => const CategoryView(),
    binding: CategoryBinding(),
  ),
  GetPage(
    name: '/mine',
    page: () => const MineView(),
    binding: MineBinding(),
  ),
  GetPage(
    name: '/addrecord',
    page: () => const AddrecordView(),
    binding: AddrecordBinding(),
  ),
];
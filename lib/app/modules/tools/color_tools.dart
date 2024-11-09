import 'package:flutter/material.dart';

///十六进制转为颜色
class FFFFFFColorTools {
  static Color fffffhexColor(String hex, {double alpha = 1}) {
    int? val;
    if (hex.toUpperCase().contains("#")) {
      hex = hex.substring(1);
    }
    if (hex.toUpperCase().contains("0X")) {
      String desString = hex.substring(2);
      val = int.tryParse("0x$desString");
    } else {
      val = int.tryParse("0x$hex");
    }
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((val! & 0xFF0000) >> 16, (val & 0x00FF00) >> 8,
        (val & 0x0000FF) >> 0, alpha);
  }

  static Color main_white_color = fffffhexColor("#FFFFFF");
  static Color main_light_grey = fffffhexColor("#F6F6F6");
  static Color main_title_text_color = fffffhexColor("#0F0F0F");
  static Color main_content_text_color = fffffhexColor("#242424");
  static Color main_green = fffffhexColor("#66BB00");
}

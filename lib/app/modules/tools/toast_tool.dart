import 'package:bot_toast/bot_toast.dart';

class FFFFFFtoastTool {
  static void ffffffShowText(String text) {
    BotToast.showText(text: text, duration: const Duration(seconds: 2));
  }

  static CancelFunc ffffffshowLoading() {
    return BotToast.showLoading();
  }
}

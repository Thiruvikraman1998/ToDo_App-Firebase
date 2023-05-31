import 'package:get/get.dart';

class AppLayout {
  static getScreenHeight() {
    return Get.height;
  }

  static getScreenWidth() {
    return Get.width;
  }

  static getHeight(double pixels) {
    var x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}

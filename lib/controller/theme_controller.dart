import 'package:get/get.dart';

class ThemeController extends GetxController{
  RxBool isLightTheme = true.obs;

  bool toggleTheme (){
    isLightTheme.value = !isLightTheme.value;
    return isLightTheme.value;
  }
}
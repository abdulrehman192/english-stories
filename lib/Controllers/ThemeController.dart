import 'package:get/get_state_manager/get_state_manager.dart';

class ThemeController extends GetxController{
  bool _isDark =false;
  //getter
  bool get isDark => _isDark;
  //setters
  set isDark(bool val)
  {
    _isDark = val;
    update();
  }
}
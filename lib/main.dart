import '/Controllers/NotificationController.dart';
import '/Controllers/TextToSpeechController.dart';
import '/Utills/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Controllers/ThemeController.dart';
import 'Views/DashBoardView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.green, // navigation bar color
  //   statusBarColor: Colors.transparent, // status bar color
  //   // color of navigation controls
  // ));
  Get.put(ThemeController());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 670),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child)
    {

      return GetBuilder<ThemeController>(
        builder: (controller) {
          return GetMaterialApp(
            title: 'English Stories',
            debugShowCheckedModeBanner: false,
            initialBinding: InitialBindings(),
            theme: kMyAppTheme[controller.isDark ? AppTheme.dark : AppTheme.light],
            home: const DashBoard(),
          );
        }
      );
    });
  }
}
class InitialBindings implements Bindings
{
  @override
  void dependencies()
  {
     Get.lazyPut(() => ScrollController(), fenix: true);
     Get.lazyPut(() => ThemeController(), fenix: true);
     Get.lazyPut(() => TextToSpeechController(), fenix: true);
     Get.lazyPut(() => NotificationController(), fenix: true);
  }
}


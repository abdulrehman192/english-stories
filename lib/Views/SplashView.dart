import 'package:interested_stories/Controllers/Controllers.dart';
import 'package:interested_stories/Controllers/NotificationController.dart';

import '/Constants/AppAssets.dart';
import '/Services/Services.dart';
import '/Views/DashBoardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState()
  {
    Get.put(()=> TextToSpeechController(), permanent: true);
    Get.put(()=> StoryController(), permanent: true);
    Get.put(()=> NotificationController(), permanent: true);
    super.initState();
    _startTimer();
  }
  _startTimer()
  {
    Future.delayed(const Duration(seconds: 2), _openScreen);
  }
  _openScreen()async
  {
     Get.off(() => const DashBoard());
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         // SizedBox(height: 30.h,),
        Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.appIcon)
            )
          ),
        ),
        ],
      ),
    );

  }
}

import 'package:englishstories/Constants/AppAssets.dart';
import 'package:englishstories/Services/Services.dart';
import 'package:englishstories/Views/DashBoardView.dart';
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
    super.initState();
    _startTimer();
  }
  _startTimer()
  {
    Future.delayed(const Duration(seconds: 0), _openScreen);
  }
  _openScreen()async
  {
    final db = SqliteService.instance;
     Get.off(() => const DashBoard());
     db.copyDatabase();
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
              image: AssetImage(AppAssets.launchImage)
            )
          ),
        ),
        ],
      ),
    );

  }
}

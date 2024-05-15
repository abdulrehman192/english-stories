import 'package:englishstories/Constants/AppAssets.dart';
import 'package:englishstories/Controllers/StoryController.dart';
import 'package:englishstories/Controllers/ThemeController.dart';
import 'package:englishstories/Models/Models.dart';
import 'package:englishstories/Models/StoryType.dart';
import 'package:englishstories/Views/StoryListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';

class HomeStoryCard extends StatelessWidget {
  final StoryType type;
  final Color backgroundColor;
  const HomeStoryCard({Key? key, required this.type, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        StoryController s = Get.find();
        s.selectedType = type.storyType.toString();
        Get.to(()=>  StoryListView(cardBackgroundColor: backgroundColor, title: type.storyType.toString(),));
      },
      child: GetBuilder<ThemeController>(
        builder: (theme) {
          return Container(
            width: 1.sw,
            height: 70.h,
            margin: EdgeInsets.all(5.h),
            padding: EdgeInsets.symmetric(vertical:8.w, horizontal: 10.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: theme.isDark ? AppColors.darkContainerColor : backgroundColor,
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 1.0,
              //     spreadRadius: 1.0,
              //     color: Colors.grey.shade200
              //   )
              // ]
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(type.imageUrl.toString()),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                SizedBox(width: 8.w,),
                Expanded(
                    child: Text("${type.storyType}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp, color: Colors.white),),
                ),
                SvgPicture.asset(AppAssets.shareIcon, width: 25.w, color: Colors.white,)
              ],
            ),
          );
        }
      ),
    );
  }
}

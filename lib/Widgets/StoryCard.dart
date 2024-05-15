import 'package:englishstories/Constants/AppAssets.dart';
import 'package:englishstories/Models/Models.dart';
import 'package:englishstories/Views/StoryDetailView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final Color backgroundColor;
  const StoryCard({Key? key, required this.story, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Get.to(()=> StoryDetailView(story: story,));
      },
      child: Container(
        width: 1.sw,
        // height: 60.h,
        constraints: BoxConstraints(
          minHeight: 60.h
        ),
        margin: EdgeInsets.all(5.h),
        padding: EdgeInsets.symmetric(vertical:8.w, horizontal: 10.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: backgroundColor,
            // boxShadow: [
            //   BoxShadow(
            //       blurRadius: 1.0,
            //       spreadRadius: 1.0,
            //       color: Colors.grey.shade200
            //   )
            // ]
        ),
        child: Row(
          children: [

            SizedBox(width: 8.w,),
            Expanded(
              child: Text("${story.title}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp, color: Colors.white),),
            ),
            SvgPicture.asset(AppAssets.shareIcon, width: 25.w, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}

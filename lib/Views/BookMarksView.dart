import 'package:englishstories/Constants/AppAssets.dart';
import 'package:englishstories/Controllers/ThemeController.dart';
import 'package:englishstories/Utills/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Constants/AppColors.dart';
import '../Controllers/StoryController.dart';
import '../Widgets/StoryCard.dart';

class BookMarks extends StatelessWidget {
  const BookMarks({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GetBuilder<ThemeController>(
          builder: (theme)
              {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
                    title: const Text("BookMarks", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
                      systemNavigationBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarIconBrightness: Brightness.dark,

                    ),
                    actions: [
                      IconButton(
                          onPressed: (){
                                 theme.isDark = !theme.isDark;
                          },
                          icon:const Icon(Icons.brightness_4,color: Colors.white,)
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: PopupMenuButton(
                          onSelected: (val)
                            {
                              CommonFunctions.shareApp("Read Amazing English Stories");
                            },
                            itemBuilder: (context)
                        {
                          return  const[
                            PopupMenuItem(
                              child:  const Text("Share App"),
                              value: "Share",

                            ),
                            PopupMenuItem(child: Text("Rate App")
                            ),

                            PopupMenuItem(child: Text("More Apps"))
                          ] ;
                        }
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding:  EdgeInsets.all(10.sp),
                    child: GetBuilder<StoryController>(
                        builder: (controller) {
                          return controller.bookmarkedStories.isNotEmpty ?
                          ListView.builder(
                              itemCount: controller.bookmarkedStories.length,
                              itemBuilder: (context, index){
                                return StoryCard(
                                    story: controller.bookmarkedStories[index],
                                    backgroundColor: theme.isDark ? AppColors.darkContainerColor : AppColors.primaryColor
                                );
                              }
                          )
                              :
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.oneStoriesImage),
                              SizedBox(height: 10.h,),
                              Text("No BookMarks",style: TextStyle(color: Colors.green.shade900,fontSize: 18,fontWeight: FontWeight.w800),),
                            ],
                          );
                        }
                    ),
                  ),
                );
              }
      );
  }
}

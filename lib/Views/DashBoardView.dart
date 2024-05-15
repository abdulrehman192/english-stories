import 'package:englishstories/Constants/AppAssets.dart';
import 'package:englishstories/Constants/AppColors.dart';
import 'package:englishstories/Controllers/StoryController.dart';
import 'package:englishstories/Controllers/ThemeController.dart';
import 'package:englishstories/Services/Services.dart';
import 'package:englishstories/Utills/CommonFunctions.dart';
import 'package:englishstories/Views/BookMarksView.dart';
import 'package:englishstories/Widgets/HomeStoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controllers/NotificationController.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    final db = SqliteService.instance;
    db.copyDatabase();
    Get.put(StoryController(), permanent: true);
    Get.put(ThemeController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (theme) {
        return Scaffold(
          drawer:  Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
            ),
            surfaceTintColor: Colors.transparent,
            child: ListView(
              children: [
                Container(
                  width: 1.w,
                  height: 180.h,
                  color: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical: 20.sp),
                        child: Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AssetImage(AppAssets.twoStoriesImage),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                        child: const Text("English Stories for Kids",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.home,color: Colors.grey.shade600,),
                    title: Text("Home",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                  ),
                  onTap: (){Get.back();},
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const  BookMarks());
                  },
                  child: ListTile(
                    leading: Icon(Icons.bookmark,color: Colors.grey.shade600,),
                    title: Text("Bookmarks",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                  ),
                ),
                Divider(
                  thickness: 1.sp,
                  color: Colors.grey.shade200,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20.sp,vertical: 10.sp),
                  child: Text("Communicate",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade500),),
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.share,color: Colors.grey.shade600,),
                    title: Text("Share",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                  ),
                  onTap: (){CommonFunctions.shareApp("Read Best English Stories");},
                ),
                ListTile(
                  leading: Icon(Icons.rate_review,color: Colors.grey.shade600,),
                  title: Text("Rate App",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                ),
                ListTile(
                  leading: Icon(Icons.apps,color: Colors.grey.shade600,),
                  title: Text("More Apps",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade600),),
                ),
              ],
            )
          ) ,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: theme.isDark ? AppColors.darkColor : AppColors.primaryColor,
            title: const Text("English Stories", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
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
                      if(val == "Share")
                        {
                          CommonFunctions.shareApp("Read amazing english stories");
                        }
                    },

                    itemBuilder: (context)
                {
                return const [
                  PopupMenuItem(
                    value: "Share",
                    child: Text("Share App"),

                  ),
                  PopupMenuItem(
                    value: "Rate",
                    child: Text("Rate App"),
                  ),
                  PopupMenuItem(
                    value: "More",
                    child: Text("More Apps"),

                  )
                ] ;
                }
                ),
              )
            ],
          ),
            body: GetBuilder<StoryController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.types.length,
                    itemBuilder: (context, index){
                  return HomeStoryCard(
                      type: controller.types[index],
                      backgroundColor: Colors.lightGreen
                  );
                }
                );
              }
            ),
        );
      }
    );
  }
}
